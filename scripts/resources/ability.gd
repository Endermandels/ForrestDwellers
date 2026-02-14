extends Resource
class_name Ability

@export_placeholder("i.e. Howl") var name_id: String = ""
@export var trigger: Enums.Trigger = Enums.Trigger.BATTLE_START
@export var conditions: Array[AbilityCondition] = []
@export var effects: Array[Effect] = []
