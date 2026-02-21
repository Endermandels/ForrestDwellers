extends Resource
class_name Stats

@export_placeholder("i.e. Wolf") var name_id: String = ""
@export var is_player: bool = false
@export var is_enemy: bool = true
@export var can_be_starter: bool = false
@export var target_rule: TargetRule = null
@export var abilities: Array[Ability] = []

@export_group("Base Stats")
@export var base_hp: int = 10
@export var base_atk: int = 1
@export var base_arm: int = 0
@export var base_spd: int = 0
@export var base_mp: int = 5
@export var base_itm: int = 1

# Variable Stats
var hp: int = base_hp
var atk: int = base_atk
var arm: int = base_arm
var spd: int = base_spd
var mp: int = base_mp
var itm: int = base_itm

# Conditions
var exhausted: bool = false ## whether this unit has already attacked this round and thus to skip its turn if it gets reordered
var wounded: bool = false ## whether this unit is wounded
var stunned: bool = false ## whether this unit is stunned

# Abilities
var abilities_sorted: Dictionary = {} ## key: Enums.Trigger, value: Array[Ability]

# Status Effects
var status_effects: Array[StatusEffect]

# House Keeping
var idx: int = -1 ## Index in units_queue of this unit
var engaged_enemy: Stats = null ## The enemy this unit is attacking or being attacked by

func _to_string() -> String:
    return name_id

func to_string_custom() -> String:
    var res = [
        "? [%s] Stats:" % name_id
        , "HP: \t%d/%d" % [hp, base_hp]
        , "ATK: \t%d" % atk
        , "ARM: \t%d" % arm
        , "SPD: \t%d" % spd
        , "MP: \t%d" % mp
        , "ITM: \t%d" % itm
    ]
    return "\n- ".join(res)
