extends Effect
class_name ApplyStatusEffect

@export var status_effect: StatusEffect

func apply(_source: Stats, target: Stats, _stacks: int = 0) -> void:
    target.add_status_effect(status_effect)