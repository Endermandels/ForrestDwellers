extends Resource
class_name Stats

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

func take_dmg(dmg: int, pure: bool = false) -> void:
    var remaining_dmg = dmg
    if not pure:
        remaining_dmg -= arm
        arm = clampi(arm - dmg, 0, arm)
    hp -= remaining_dmg

func add_status_effect(status_effect: StatusEffect) -> void:
    status_effects.append(status_effect)