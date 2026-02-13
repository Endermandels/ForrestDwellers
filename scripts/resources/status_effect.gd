extends Resource
class_name StatusEffect

@export var trigger: Enums.Trigger = Enums.Trigger.TURN_START
@export var stacks: int = 1
@export var effects: Array[Effect] = []

func apply(stats: Stats) -> void:
    for e: Effect in effects:
        e.apply(null, stats, stacks)