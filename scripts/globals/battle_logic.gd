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
	sort_units_queue()
	populate_abilities_queue(Enums.Trigger.BATTLE_START, game_state.units_queue)

## Print all units stats
func print_stats() -> void:
	for unit: Stats in game_state.units_queue:
		print(unit.to_string_custom())
	if game_state.cur_unit:
		print(game_state.cur_unit.to_string_custom())

# ## Remove all dead units from units_queue
# func remove_dead_units() -> void:
# 	var to_remove: Array[int] = []
# 	for i in range(game_state.units_queue.size()):
# 		if game_state.units_queue[i].is_dead():
# 			to_remove.push_front(i)
# 	for i in to_remove:
# 		game_state.units_queue.remove_at(i)

## Sort units_queue by SPD
func sort_units_queue() -> void:
	# TODO: Implement the following:
	# Whenever a unit's SPD changes, re-sort the units_queue
	# When a unit has attacked, it is exhausted and cannot start its turn again until the next round
	# So, when a unit who has attacked gets its SPD lowered, and thus goes down the queue,
	#  when it is encountered in the queue it is skipped over

	print("* Sort units by SPD")
	game_state.units_queue.sort_custom(func (a: Stats, b: Stats): return a.spd > b.spd)
	game_state.units_sorted = true

## Populate abilities_queue with [trigger] abilities
func populate_abilities_queue(trigger: Enums.Trigger, units: Array[Stats]) -> void:
	var trigger_name = Enums.Trigger.keys()[trigger] # have to convert trigger to str using this line
	print("* Populate Abilities queue")
	for u in units:
		for a in u.abilities_sorted[trigger_name]:
			game_state.abilities_queue.append(a)

## Init each unit's stats
func init_units_queue() -> void:
	for u in game_state.units_queue:
		stats_init(u)
#endregion

#region Stats
## TODO: This will reset a unit's stats. To make stats persistent, this will need to change
## Init stats to base values
func stats_init(stats: Stats) -> void:
	stats.hp = stats.base_hp
	stats.atk = stats.base_atk
	stats.arm = stats.base_arm
	stats.spd = stats.base_spd
	stats.mp = stats.base_mp
	stats.itm = stats.base_itm
	stats_sort_abilities(stats)

## Sort abilities by trigger
func stats_sort_abilities(stats: Stats) -> void:
	for trigger in Enums.Trigger:
		stats.abilities_sorted[str(trigger)] = []
	for a in stats.abilities:
		for trigger in a.triggers:
			stats.abilities_sorted[str(trigger)].append(a)

## Exhaust [stats]
func stats_exhaust(stats: Stats) -> void:
	stats.exhausted = true

## Remove exhaust on [stats]
func stats_refresh(stats: Stats) -> void:
	stats.exhausted = false

## Returns whether [stats] is dead
func stats_is_dead(stats: Stats) -> bool:
	return stats.hp <= 0

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

#region State Machine
func step_battle_start() -> void:
	if game_state.abilities_queue.size() > 0:
		var ability: Ability = game_state.abilities_queue.pop_front()
		var unit: Stats = ability.unit_ref

		stats_apply_ability_effects(unit, ability, game_state.units_queue)
	else:
		game_state.battle_state = Enums.BattleState.TURN_START
		game_state.cur_unit = game_state.units_queue.pop_front()
		print("~~~ [%s] Turn Start ~~~" % game_state.cur_unit)
		populate_abilities_queue(Enums.Trigger.TURN_START, game_state.units_queue)

func step_turn_start() -> void:
	if game_state.abilities_queue.size() > 0:
		var ability: Ability = game_state.abilities_queue.pop_front()
		var unit: Stats = ability.unit_ref

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

		var enemy_wounded_prev = engaged_enemy.wounded
		var dmg_effect: DamageEffect = DamageEffect.new()
		dmg_effect.dmg = unit.atk
		dmg_effect.apply(unit, engaged_enemy)

		# Trigger Wounded On Hurt Abilities
		if not enemy_wounded_prev and engaged_enemy.wounded:
			for a in engaged_enemy.abilities[Enums.Trigger.WOUNDED_ON_HURT]:
				game_state.abilities_queue.insert(game_state.cur_ability_idx + 1, a)

		populate_abilities_queue(Enums.Trigger.ON_HIT, [unit])
		populate_abilities_queue(Enums.Trigger.ON_HURT, [engaged_enemy])

		game_state.battle_state = Enums.BattleState.ATTACK_RESOLUTION
	else:
		game_state.battle_state = Enums.BattleState.TURN_END
		if not stats_is_dead(game_state.cur_unit):
			game_state.units_queue.append(game_state.cur_unit)
		game_state.cur_unit = null
		print("~~~ [%s] Turn End ~~~" % game_state.cur_unit)
		stats_exhaust(game_state.cur_unit)
		populate_abilities_queue(Enums.Trigger.TURN_END, game_state.units_queue)

func step_attack_resolution() -> void:
	if game_state.abilities_queue.size() > 0:
		var ability: Ability = game_state.abilities_queue.pop_front()
		var unit: Stats = ability.unit_ref

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
	elif game_state.battle_state == Enums.BattleState.ATTACK_RESOLUTION:
		step_attack_resolution()
	elif game_state.battle_state == Enums.BattleState.TURN_END:
		step_turn_end()
	else:
		assert(false, "Unknown battle state: %s" % str(game_state.battle_state))
#endregion