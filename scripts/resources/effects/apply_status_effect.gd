extends Effect
class_name ApplyStatusEffect

@export var status_effect: StatusEffect

func apply(_source: Stats, target: Stats, _stacks: int = 0) -> void:
	target.status_effects.append(status_effect)