extends Resource
class_name GameState

enum Scenes {
    BATTLE
}

@export var current_scene: Scenes = Scenes.BATTLE

@export_group("Battle")
@export var turn: int = 0
@export var battle_state: Enums.BattleState = Enums.BattleState.BATTLE_START
@export var battle_participants: Array[Stats] = []
var previous_battle_state: Enums.BattleState = Enums.BattleState.BEFORE_BATTLE
