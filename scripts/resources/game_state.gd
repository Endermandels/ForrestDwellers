extends Resource
class_name GameState

enum Scenes {
    BATTLE
}

@export var current_scene: Scenes = Scenes.BATTLE

@export_group("Battle")
@export var units_queue: Array[Stats] = [] ## Highest SPD to lowest SPD
var abilities_queue: Array[Ability] = [] ## First Ability to last Ability
var attack_queue: Array[Stats] = [] ## cur_unit attacks each unit in the attack queue
var player_units: Array[int] = [] ## indices to the player units in units_queue
var enemy_units: Array[int] = [] ## indices to the enemy units in units_queue
var battle_state: Enums.BattleState = Enums.BattleState.BATTLE_START
var battle_turn: int = -1
var cur_unit: Stats = null
var units_sorted: bool = false
