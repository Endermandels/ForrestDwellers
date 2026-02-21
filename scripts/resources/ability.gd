extends Resource
class_name Ability

const IS_LIVING = preload("res://resources/common_ability_conditions/is_living.tres")

@export_placeholder("i.e. Howl") var name_id: String = ""
@export var triggers: Array[Enums.Trigger] = [Enums.Trigger.BATTLE_START]
@export var conditions: Array[AbilityCondition] = [IS_LIVING]
@export var effects: Array[Effect] = []
var unit_ref: Stats = null ## Unit using this ability, null if no unit cast this ability