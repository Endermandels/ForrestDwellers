extends Effect
class_name DamageEffect

@export var dmg: int = 1
@export var dmg_change: int = 0 ## how much to increase/decrease damage each time it is applied
@export var dmg_per_stack: int = 0 ## how much damage is dealt per stack left
@export var dmg_max_is_stacks: bool = false ## whether the max damage dealt is equal to the number of stacks left
@export var pure: bool = false ## whether to ignore armor

func apply(_source: Stats, target: Stats, stacks: int = 0) -> void:
    var dmg_to_apply = dmg + (dmg_per_stack * stacks)
    dmg_to_apply = max(dmg_to_apply, 0)
    if dmg_max_is_stacks:
        dmg_to_apply = min(dmg_to_apply, stacks)
    target.take_dmg(dmg_to_apply, pure)
    dmg = max(dmg + dmg_change, 0)