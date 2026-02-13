extends Effect
class_name DamageEffect

@export var dmg: int = 1
@export var dmg_change: int = 0 ## how much to increase/decrease damage each time it is applied
@export var dmg_per_stack: int = 0 ## how much damage is dealt per stack left
@export var dmg_max_is_stacks: bool = false ## whether the max damage dealt is equal to the number of stacks left
@export var pure: bool = false ## whether to ignore armor

func apply(_source: Stats, targets: Array[Stats], stacks: int) -> void:
    var dmg_to_apply = clampi(dmg + (dmg_per_stack * stacks), 0, stacks if dmg_max_is_stacks else int(INF))

    for t: Stats in targets:
        t.take_dmg(dmg_to_apply, pure)

    dmg = clampi(dmg + dmg_change, 0, int(INF))