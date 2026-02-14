extends Node
# Global

var game_state: GameState = null
var initialized: bool = false

#region Helper Functions
## Initialize a new battle 
func init() -> void:
	if not initialized:
		game_state = load("res://resources/game_state.tres")
		initialized = true
	
	print("~~~ Battle Start ~~~")
	init_units_queue()
	populate_abilities_queue(Enums.Trigger.BATTLE_START)

## Print all units stats
func print_stats() -> void:
	for unit: Stats in game_state.units_queue:
		print(unit)

## Remove all dead units from units_queue
func remove_dead_units() -> void:
	var to_remove: Array[int] = []
	for i in range(game_state.units_queue.size()):
		if game_state.units_queue[i].is_dead():
			to_remove.push_front(i)
	for i in to_remove:
		game_state.units_queue.remove_at(i)

## Sort units_queue by SPD
func sort_units_queue() -> void:
	# Whenever a unit's SPD changes, re-sort the units_queue
	# When a unit has attacked, it is exhausted and cannot start its turn again until the next round
	# So, when a unit who has attacked gets its SPD lowered, and thus goes down the queue,
	#  when it is encountered in the queue it is skipped over

	print("* Sort units by SPD")
	game_state.units_queue.sort_custom(func (a: Stats, b: Stats): return a.spd > b.spd)
	game_state.player_units = []
	game_state.enemy_units = []
	var i: int = 0
	for u in game_state.units_queue:
		u.idx = i
		if not u.is_dead():
			if u.is_enemy:
				game_state.enemy_units.append(i)
			else:
				game_state.player_units.append(i)
		i += 1
	game_state.units_sorted = true

## Populate abilities_queue with [trigger] abilities
func populate_abilities_queue(trigger: Enums.Trigger) -> void:
	print("* Populate Abilities queue")
	for u in game_state.units_queue:
		for a in u.abilities_sorted[trigger]:
			var dict = {
				"unit": u,
				"ability": a,
			}
			game_state.abilities_queue.append(dict)

## Call each unit's init function in units_queue
func init_units_queue() -> void:
	for u in game_state.units_queue:
		u.init()
#endregion

#region Stats
## Init stats to base values
func stats_init(stats: Stats) -> void:
	stats.hp = stats.base_hp
	stats.atk = stats.base_atk
	stats.arm = stats.base_arm
	stats.spd = stats.base_spd
	stats.mp = stats.base_mp
	stats.itm = stats.base_itm

## Sort abilities by trigger
func stats_sort_abilities(stats: Stats) -> void:
	for trigger in Enums.Trigger:
		stats.abilities_sorted[trigger] = []
	for a in stats.abilities:
		stats.abilities_sorted[a.trigger].append(a)

## Deal [dmg] to [stats]. 
## [pure] determines whether to ignore ARM.
## [on_hurt] determines whether the DMG was received via an attack instead of a status effect or something else.
func stats_take_dmg(stats: Stats, dmg: int, pure: bool = false, on_hurt: bool = false) -> void:
	print("* [%s] received %d%sDMG" % [stats.name_id, dmg, " Pure " if pure else " "])
	var remaining_dmg = dmg

	if not pure:
		remaining_dmg = max(dmg - stats.arm, 0)
		stats.arm = max(stats.arm - dmg, 0)

	stats.hp = max(stats.hp - remaining_dmg, 0)

	if stats.hp < float(stats.base_hp) / 2:
		if not stats.wounded:
			stats.wounded = true
			# Trigger wounded abilities
			for a in stats.abilities[Enums.Trigger.WOUNDED]:
				game_state.abilities_queue.insert(game_state.cur_ability_idx + 1, [stats.idx, a])
			if on_hurt:
				# Trigger wounded on hurt abilities
				for a in stats.abilities[Enums.Trigger.WOUNDED_ON_HURT]:
					game_state.abilities_queue.insert(game_state.cur_ability_idx + 1, [stats.idx, a])

## Reduce [amount] of [stats] MP
func stats_reduce_mp(stats: Stats, amount: int) -> void:
	stats.mp = max(stats.mp - amount, 0)

## Add [status_effect] to [stats]
func stats_add_status_effect(stats: Stats, status_effect: StatusEffect) -> void:
	stats.status_effects.append(status_effect)

## Returns index of enemy unit [stats] is targeting
func stats_get_target(stats: Stats, enemy_units: Array[int], units_queue: Array[Stats]) -> int:
	var res: int = -1

	if stats.target_bias == Enums.TargetBias.RANDOM:
		res = enemy_units.pick_random()
	elif stats.target_bias == Enums.TargetBias.HIGH_HP:
		var highest: Stats = null
		for i in enemy_units:
			# Since units_queue is sorted by SPD, reward higher SPD by attacking lower SPD on a tie
			if not highest or units_queue[i].hp >= highest.hp:
				res = i
				highest = units_queue[i]
	else:
		print("TODO: Implement Target Type [%s]" % stats.target_bias)
	
	return res

## Returns whether [stats] is dead
func stats_is_dead(stats: Stats) -> bool:
	return stats.hp <= 0

#region Ability
## Returns whether [stats] meet all [ability] conditions 
func stats_meet_ability_conditions(stats: Stats, ability: Ability, enemy: Stats = null) -> bool:
	var res = true
	for c: AbilityCondition in ability.conditions:
		if c.conjuction == Enums.ConditionConjunction.AND:
			res = res && c.condition_met(stats, enemy)
		elif c.conjuction == Enums.ConditionConjunction.OR:
			res = res || c.condition_met(stats, enemy)
	return res

## Returns whether [stats] meet [ability] cost
func stats_meet_ability_cost(stats: Stats, ability: Ability) -> bool:
	var res = false
	if ability.cost_type == Enums.AbilityCostType.MP:
		res = stats.mp >= ability.cost_amount
	else:
		print("TODO: Implement Cost Type [%s]" % str(ability.cost_type))
	return res

## Returns whether [stats] can use [ability]
func stats_can_use_ability(stats: Stats, ability: Ability, enemy: Stats = null) -> bool:
	return stats_meet_ability_cost(stats, ability) && stats_meet_ability_conditions(stats, ability, enemy)

## Applies [stats]'s [ability]'s effects to the target unit(s)
func stats_apply_ability_effects(stats: Stats, ability: Ability, units_queue: Array[Stats]) -> void:
	print("* [%s] used %s" % [stats.name_id, ability.name_id])
	for e in ability.effects:
		for t in e.target_rule.get_targets(stats, units_queue):
			e.apply(stats, t)
#endregion
#endregion

#region State Machine
func step_battle_start() -> void:
	if game_state.abilities_queue.size() > 0:
		var info: Dictionary = game_state.abilities_queue.pop_front()
		var unit: Stats = info["unit"]
		var ability: Ability = info["ability"]

		stats_apply_ability_effects(unit, ability, game_state.units_queue)
	else:
		game_state.battle_state = Enums.BattleState.TURN_START
		game_state.battle_round = 0
		game_state.cur_unit = game_state.units_queue[0]
		print("~~~ [%s] Turn Start ~~~" % game_state.cur_unit)
		populate_abilities_queue(Enums.Trigger.TURN_START)

func step_turn_start() -> void:
	if game_state.abilities_queue.size() > 0:
		var info: Dictionary = game_state.abilities_queue.pop_front()
		var unit: Stats = info["unit"]
		var ability: Ability = info["ability"]

		stats_apply_ability_effects(unit, ability, game_state.units_queue)
	else:
		game_state.battle_state = Enums.BattleState.ATTACK
		var unit: Stats = game_state.cur_unit
		var targets: Array[Stats] = unit.target_rule.get_targets(unit, game_state.units_queue)
		game_state.attack_queue = targets
		print("~~~ [%s] Attack ~~~" % game_state.cur_unit)

func step_attack() -> void:
	if game_state.attack_queue.size() > 0:
		var engaged_enemy: Stats = game_state.attack_queue.pop_front()
		var unit: Stats = game_state.cur_unit

		stats_take_dmg(engaged_enemy, unit.atk, false, true)

		populate_abilities_queue(Enums.Trigger.ON_HIT)
		populate_abilities_queue(Enums.Trigger.ON_HURT)
		game_state.battle_state = Enums.BattleState.ATTACK_RESOLUTION
	else:
		game_state.battle_state = Enums.BattleState.TURN_END
		print("~~~ [%s] Turn End ~~~" % game_state.cur_unit)
		populate_abilities_queue(Enums.Trigger.TURN_END)

func step_attack_resolution() -> void:
	if game_state.abilities_queue.size() > 0:
		var info: Dictionary = game_state.abilities_queue.pop_front()
		var unit: Stats = info["unit"]
		var ability: Ability = info["ability"]

		stats_apply_ability_effects(unit, ability, game_state.units_queue)
	else:
		game_state.battle_state = Enums.BattleState.ATTACK

func step_turn_end() -> void:
	step_battle_start()

func advance_battle_state(_input_cmp: InputComponent) -> void:
	if not game_state: return

	if game_state.battle_state == Enums.BattleState.BATTLE_START:
		step_battle_start()
	elif game_state.battle_state == Enums.BattleState.TURN_START:
		step_turn_start()
	elif game_state.battle_state == Enums.BattleState.ATTACK:
		step_attack()
	elif game_state.battle_state == Enums.BattleState.TURN_END:
		step_turn_end()
	else:
		push_error("Unknown battle state: %s" % str(game_state.battle_state))
		get_tree().quit()
#endregion