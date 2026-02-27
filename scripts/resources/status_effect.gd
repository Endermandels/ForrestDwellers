extends Resource
class_name StatusEffect

@export_placeholder("i.e. poison") var name_id: String = "" 
@export var triggers: Array[Enums.Trigger] = [Enums.Trigger.TURN_START]
@export var stacks: int = 1
@export var effects: Array[Effect] = []
