extends Effect
class_name DrainEffect

@export var drain_per_stack: int = 1 ## how much DRN is dealt per stack left

func apply(_source: Stats, target: Stats, stacks: int = 1) -> void:
	var drain_to_apply = drain_per_stack * stacks
	drain_to_apply = max(drain_to_apply, 0) # Apply at least 0 DRN
	target.mp = max(target.mp - drain_to_apply, 0) # Reduce MP by DRN