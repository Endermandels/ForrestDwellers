extends Node2D
class_name Battle

func _ready() -> void:
    BattleLogic.init()

func _process(_delta: float) -> void:
    BattleLogic.update()