extends Resource
class_name GameState

enum Scenes {
    BATTLE
}

@export var current_scene: Scenes = Scenes.BATTLE

@export_group("Battle")
@export var turn: int = 0
@export var battle_state: Enums.BattleState = Enums.BattleState.BATTLE_START
@export var all_units: Array[Stats] = []
@export var cur_unit_idx: int = 0
@export var cur_unit_ability_idx: int = 0
var units_sorted: bool = false
