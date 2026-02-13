extends Resource
class_name AbilityCondition

enum StatSource1 {
    SELF_HP,
    SELF_ATK,
    SELF_ARM,
    SELF_SPD,
    SELF_MP,
    ENEMY_HP,
    ENEMY_ATK,
    ENEMY_ARM,
    ENEMY_SPD,
    ENEMY_MP,
}

enum StatSource2 {
    SELF_HP,
    SELF_ATK,
    SELF_ARM,
    SELF_SPD,
    SELF_MP,
    ENEMY_HP,
    ENEMY_ATK,
    ENEMY_ARM,
    ENEMY_SPD,
    ENEMY_MP,
    SCALAR,
}

enum Stat {
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

@export var source_1: StatSource1 = StatSource1.SELF_MP ## source of the left stat
@export var source_2: StatSource2 = StatSource2.SCALAR ## source of the right stat
@export var operation: Operation = Operation.GREATER_THAN ## the operation to be performed between source 1 and source 2
@export var scalar: int = 0 ## only used if source 2 is an SCALAR
@export var conjuction: Enums.ConditionConjunction = Enums.ConditionConjunction.AND ## how this condition will conjoin with the next condition

var mapped_source_1 = {
    StatSource1.SELF_HP: func (s: Stats, _e: Stats): return s.hp,
    StatSource1.SELF_ATK: func (s: Stats, _e: Stats): return s.atk,
    StatSource1.SELF_ARM: func (s: Stats, _e: Stats): return s.arm,
    StatSource1.SELF_SPD: func (s: Stats, _e: Stats): return s.spd,
    StatSource1.SELF_MP: func (s: Stats, _e: Stats): return s.mp,
    StatSource1.ENEMY_HP: func (_s: Stats, e: Stats): assert(e); return e.hp,
    StatSource1.ENEMY_ATK: func (_s: Stats, e: Stats): assert(e); return e.atk,
    StatSource1.ENEMY_ARM: func (_s: Stats, e: Stats): assert(e); return e.arm,
    StatSource1.ENEMY_SPD: func (_s: Stats, e: Stats): assert(e); return e.spd,
    StatSource1.ENEMY_MP: func (_s: Stats, e: Stats): assert(e); return e.mp,
}

var mapped_source_2 = {
    StatSource2.SELF_HP: func (s: Stats, _e: Stats): return s.hp,
    StatSource2.SELF_ATK: func (s: Stats, _e: Stats): return s.atk,
    StatSource2.SELF_ARM: func (s: Stats, _e: Stats): return s.arm,
    StatSource2.SELF_SPD: func (s: Stats, _e: Stats): return s.spd,
    StatSource2.SELF_MP: func (s: Stats, _e: Stats): return s.mp,
    StatSource2.ENEMY_HP: func (_s: Stats, e: Stats): assert(e); return e.hp,
    StatSource2.ENEMY_ATK: func (_s: Stats, e: Stats): assert(e); return e.atk,
    StatSource2.ENEMY_ARM: func (_s: Stats, e: Stats): assert(e); return e.arm,
    StatSource2.ENEMY_SPD: func (_s: Stats, e: Stats): assert(e); return e.spd,
    StatSource2.ENEMY_MP: func (_s: Stats, e: Stats): assert(e); return e.mp,
    StatSource2.SCALAR: func (_s: Stats, _e: Stats): return scalar,
}

var mapped_operation = {
    Operation.GREATER_THAN: func (x, y): return x > y,
    Operation.LESS_THAN: func (x, y): return x < y,
    Operation.EQUAL: func (x, y): return x == y,
    Operation.NOT_EQUAL: func (x, y): return x != y,
}

func condition_met(source: Stats, enemy: Stats = null) -> bool:
    assert(source)
    
    var s1: int = mapped_source_1[source_1].call(source, enemy)
    var s2: int = mapped_source_2[source_2].call(source, enemy)

    return mapped_operation[operation].call(s1, s2)