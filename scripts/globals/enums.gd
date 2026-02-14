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

enum BattleState {
    BATTLE_START,
    TURN_START,
    ATTACK,
    ATTACK_RESOLUTION,
    TURN_END,
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