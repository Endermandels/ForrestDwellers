extends Node2D
class_name Battle

@export_group("Nodes")
@export var input_cmp: InputComponent

func _ready() -> void:
    BattleLogic.init()

func _process(_delta: float) -> void:
    if input_cmp.get_step_battle_input():
        BattleLogic.advance_battle_state(input_cmp)
    if input_cmp.get_print_stats_input():
        BattleLogic.print_stats()