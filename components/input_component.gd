extends Node
class_name InputComponent

var debug_step_battle: bool = false
var debug_print_stats: bool = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("debug_step_battle"):
		debug_step_battle = true
	if Input.is_action_just_pressed("debug_print_stats"):
		debug_print_stats = true

func get_step_battle_input() -> bool:
	var res = debug_step_battle
	debug_step_battle = false
	return res

func get_print_stats_input() -> bool:
	var res = debug_print_stats
	debug_print_stats = false
	return res
