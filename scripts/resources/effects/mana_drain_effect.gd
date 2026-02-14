extends Effect
class_name ManaDrainEffect

@export var drain: int = 1 ## how much to decrease 
@export var drain_change: int = 0 ## how much to increase/decrease drain each time it is applied
@export var drain_per_stack: int = 0 ## how much drain is dealt per stack left
@export var drain_max_is_stacks: bool = false ## whether the max drain dealt is equal to the number of stacks left

func apply(_source: Stats, target: Stats, stacks: int = 0) -> void:
    var drain_to_apply = drain + (drain_per_stack * stacks)
    drain_to_apply = max(drain_to_apply, 0)
    if drain_max_is_stacks:
        drain_to_apply = min(drain_to_apply, stacks)
    target.take_drain(drain_to_apply)
    drain = max(drain + drain_change, 0)