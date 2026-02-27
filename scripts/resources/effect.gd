extends Resource
class_name Effect

@export var target_rule: TargetRule = null

## Apply an effect from [source] to [target] (determined by [target_rule]) with [stacks] left
func apply(_source: Stats, _target: Stats, _stacks: int = 1) -> void:
    pass