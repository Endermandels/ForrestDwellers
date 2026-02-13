extends Effect
class_name ApplyStatusEffect

@export var status_effect: StatusEffect

func apply(_source: Stats, targets: Array[Stats], stacks: int) -> void:
    for t: Stats in targets:
        t.add_status_effect(status_effect)