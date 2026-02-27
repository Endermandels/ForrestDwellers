extends Effect
class_name ApplyStatusEffect

@export var status_effect: StatusEffect

func apply(_source: Stats, target: Stats, stacks: int = 1) -> void:
	var found_status_effect: bool = false
	for s in target.status_effects:
		if s.name_id == status_effect.name_id:
			s.stacks += stacks
			found_status_effect = true
	if not found_status_effect:
		target.status_effects.append(status_effect)
	
