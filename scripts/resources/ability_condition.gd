extends Resource
class_name AbilityCondition

enum TargetUnit {
    SELF,
    ENEMY,
}

enum TargetStat {
    HP,
    ATK,
    ARM,
    SPD,
    MP,
}

enum Operation {
    GREATER_THAN,
    LESS_THAN,
    EQUAL,
    NOT_EQUAL,
}

enum Conjunction {
    AND,
    OR
}

@export var target_unit: TargetUnit = TargetUnit.SELF
@export var target_stat: TargetStat = TargetStat.ARM
@export var operation: Operation = Operation.GREATER_THAN
@export var amount: int = 0
@export var conjuction: Conjunction = Conjunction.AND
