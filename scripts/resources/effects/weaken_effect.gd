extends Effect
class_name WeakenEffect

func apply(_source: Stats, target: Stats, stacks: int = 1) -> void:
	target.atk = max(target.atk - stacks, 0)