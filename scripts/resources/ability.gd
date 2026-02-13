extends Resource
class_name Ability

enum Target {
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

@export_placeholder("i.e. Howl") var name_id: String = ""
@export var trigger: Enums.Trigger = Enums.Trigger.BATTLE_START
@export var conditions: Array[AbilityCondition] = []
@export var cost_type: CostType = CostType.MP
@export var cost_amount: int = 1
@export var targets: Target = Target.SELF
@export var effects: Array[Effect] = []

## Returns whether the given stats have the required ability cost
func meets_cost(stats: Stats) -> bool:
    var res = false
    if cost_type == CostType.MP:
        res = stats.mp >= cost_amount
    else:
        print("TODO: Implement Cost Type [%s]" % str(cost_type))
    return res

## Pay the ability cost
func pay_cost(stats: Stats) -> void:
    if cost_type == CostType.MP:
        stats.use_mp(cost_amount)
    else:
        print("TODO: Implement Cost Type [%s]" % str(cost_type))

## Returns whether the all the ability conditions are met 
## given the source of the ability and when applicable the enemy of the source unit
func meets_conditions(source: Stats, enemy: Stats = null) -> bool:
    var res = true
    for c: AbilityCondition in conditions:
        if c.conjuction == Enums.ConditionConjunction.AND:
            res = res && c.condition_met(source, enemy)
        elif c.conjuction == Enums.ConditionConjunction.OR:
            res = res || c.condition_met(source, enemy)
    return res

## Applies the ability's effects to the target unit(s)
func apply_effects(source: Stats, all_units: Array[Stats]) -> void:
    print("* [%s] used %s" % [source.name_id, name_id])
    pay_cost(source)
    if targets == Target.SELF:
        for e in effects:
            e.apply(source, source)
    elif targets == Target.ALL_ENEMIES:
        for u in all_units:
            if u.is_enemy != source.is_enemy:
                for e in effects:
                    e.apply(source, u)
    elif targets == Target.ATTACKED_ENEMY:
        pass
    else:
        print("TODO: Implement target type [%s]" % str(targets))
