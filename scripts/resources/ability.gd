extends Resource
class_name Ability

enum AbilityTarget {
    SELF,
    ALL,
    ALL_ENEMIES,
    ALL_ALLIES,
    OTHER_ALLIES,
    ATTACKING_ENEMY,
    ATTACKED_ENEMY,
}

enum CostType {
    MP,
    HP,
    ATK,
    SPD
}

@export var trigger: Enums.Trigger = Enums.Trigger.BATTLE_START
@export var condition: Array[AbilityCondition] = []
@export var cost_type: CostType = CostType.MP
@export var cost_amount: int = 1
@export var targets: AbilityTarget = AbilityTarget.SELF
@export var effects: Array[Effect] = []
