extends Node
# Global

var game_state: GameState

func init() -> void:
	game_state = load("res://resources/game_state.tres")
	print("* Init unit stats")
	for unit: Stats in game_state.all_units:
		unit.init_stats()

func print_stats() -> void:
	for unit: Stats in game_state.all_units:
		print(unit)

func handle_battle_start() -> void:
	print("~~~ Battle Start ~~~")
	print("* Sort units by SPD")
	game_state.all_units.sort_custom(func (a: Stats, b: Stats): return a.spd > b.spd)
	print("* Activate unit Battle Start abilities")
	for unit: Stats in game_state.all_units:
		for a: Ability in unit.abilities:
			if (a.trigger == Enums.Trigger.BATTLE_START
				and a.meets_cost(unit)
				and a.meets_conditions(unit)):
					a.apply_effects(unit, game_state.all_units)
	game_state.battle_state = Enums.BattleState.TURN_START

func handle_turn_start() -> void:
	print("~~~ Turn Start ~~~")
	print("TODO")
	game_state.battle_state = Enums.BattleState.ACTION

func handle_turn_action() -> void:
	print("~~~ Action ~~~")
	print("TODO")
	game_state.battle_state = Enums.BattleState.TURN_END

func handle_turn_end() -> void:
	print("~~~ Turn End ~~~")
	print("TODO")
	game_state.battle_state = Enums.BattleState.TURN_START

func advance_battle_state(input_cmp: InputComponent) -> void:
	if not game_state: return

	if game_state.battle_state == Enums.BattleState.BATTLE_START:
		handle_battle_start()
	elif game_state.battle_state == Enums.BattleState.TURN_START:
		handle_turn_start()
	elif game_state.battle_state == Enums.BattleState.ACTION:
		handle_turn_action()
	elif game_state.battle_state == Enums.BattleState.TURN_END:
		handle_turn_end()
	else:
		push_error("Unknown battle state: %s" % str(game_state.battle_state))
		get_tree().quit()
