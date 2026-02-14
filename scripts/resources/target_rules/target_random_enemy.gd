extends TargetRule
class_name TargetRandomEnemy

func get_targets(stats: Stats, units_queue: Array[Stats]) -> Array[Stats]:
    var enemy_units: Array[Stats] = []

    for u in units_queue:
        if u.is_enemy != stats.is_enemy:
            enemy_units.append(u)
    
    return [enemy_units.pick_random()]
