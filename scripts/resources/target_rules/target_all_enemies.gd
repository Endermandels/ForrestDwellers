extends TargetRule
class_name TargetAllEnemies

func get_targets(stats: Stats, units_queue: Array[Stats]) -> Array[Stats]:
    var res = []
    for u in units_queue:
        if u.is_enemy != stats.is_enemy:
            res.append(u)
    return res
