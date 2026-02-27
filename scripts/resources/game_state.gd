extends Resource
class_name GameState

enum Scenes {
    BATTLE
}

@export var current_scene: Scenes = Scenes.BATTLE

@export_group("Battle")
@export var units_queue: Array[Stats] = [] ## Highest SPD to lowest SPD
var abilities_queue: Array[Ability] = [] ## First Ability to last Ability
# var status_effects_queue: Array[StatusEffect] = [] ## First Status Effect to last Status Effect
var attack_queue: Array[Stats] = [] ## cur_unit attacks each unit in the attack queue
var battle_state: Enums.BattleState = Enums.BattleState.BATTLE_START
var cur_unit: Stats = null
var player: Stats = null
