extends Resource
class_name Stats

@export_placeholder("i.e. Wolf") var name_id: String = ""
@export var is_player: bool = false
@export var is_enemy: bool = true
@export var can_be_starter: bool = false
@export var targets: Enums.Target = Enums.Target.RANDOM
@export var abilities: Array[Ability]

@export_group("Base Stats")
@export var base_hp: int = 10
@export var base_atk: int = 1
@export var base_arm: int = 0
@export var base_spd: int = 0
@export var base_mp: int = 5
@export var base_itm: int = 1

var hp: int = base_hp
var atk: int = base_atk
var arm: int = base_arm
var spd: int = base_spd
var mp: int = base_mp
var itm: int = base_itm

var status_effects: Array[StatusEffect]

func _to_string() -> String:
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

func init_stats() -> void:
    hp = base_hp
    atk = base_atk
    arm = base_arm
    spd = base_spd
    mp = base_mp
    itm = base_itm

func take_dmg(dmg: int, pure: bool = false) -> void:
    print("* [%s] received %d%sDMG" % [name_id, dmg, " Pure " if pure else " "])
    var remaining_dmg = dmg
    if not pure:
        remaining_dmg = max(dmg - arm, 0)
        arm = max(arm - dmg, 0)
    hp = max(hp - remaining_dmg, 0)

func use_mp(amount: int) -> void:
    print("* [%s] paid %d MP" % [name_id, amount])
    mp = max(mp - amount, 0)

func add_status_effect(status_effect: StatusEffect) -> void:
    status_effects.append(status_effect)