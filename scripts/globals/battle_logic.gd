extends Node
# Global

var game_state: GameState

func init() -> void:
	game_state = load("res://resources/game_state.tres")

func update() -> void:
	if not game_state: return

	var new_battle_state = game_state.previous_battle_state != game_state.battle_state
	game_state.previous_battle_state = game_state.battle_state

	if game_state.battle_state == Enums.BattleState.BATTLE_START:
		if new_battle_state:
			print("~~~ Battle Start ~~~")
			print("TODO")
			game_state.battle_state = Enums.BattleState.TURN_START
	elif game_state.battle_state == Enums.BattleState.TURN_START:
		if new_battle_state:
			print("~~~ Turn Start ~~~")
	elif game_state.battle_state == Enums.BattleState.ACTION:
		if new_battle_state:
			print("~~~ Action ~~~")
	elif game_state.battle_state == Enums.BattleState.TURN_END:
		if new_battle_state:
			print("~~~ Turn End ~~~")
	else:
		push_error("Unknown battle state: %s" % str(game_state.battle_state))
		get_tree().quit()
