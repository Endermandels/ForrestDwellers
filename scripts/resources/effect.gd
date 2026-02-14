extends Resource
class_name Effect

@export var target_rule: TargetRule = null

## Apply an effect from [source] to [target] (determined by [target_rule]) with [stacks] left, if applicable
func apply(_source: Stats, _target: Stats, _stacks: int = 0) -> void:
    pass