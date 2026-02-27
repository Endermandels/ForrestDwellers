extends Node
# Global

enum TargetBias {
    RANDOM,
    HIGH_BASE_HP,
    HIGH_HP,
    LOW_BASE_HP,
    LOW_HP,
    HIGH_ATK,
    HIGH_ARM,
    LOW_ARM,
    HIGH_SPD,
    LOW_SPD,
}

enum Trigger {
    BATTLE_START,
    TURN_START,
    TURN_END,
    ALTERNATE,
    ON_HIT,
    ON_HURT,
    WOUNDED,
    WOUNDED_ON_HURT,
    PASSIVE,
}

func get_trigger_name(trigger: Trigger) -> String:
    return str(Trigger.keys()[trigger])

enum BattleState {
    BATTLE_START,
    TURN_START_ABILITIES,
    TURN_START_STATUS_EFFECTS,
    ATTACK,
    ATTACK_RESOLUTION,
    TURN_END_ABILITIES,
    TURN_END_STATUS_EFFECTS,
    BATTLE_RESOLUTION,
}

enum ConditionConjunction {
    AND,
    OR,
}

enum AbilityCostType {
    HP,
    ATK,
    SPD,
    MP,
}