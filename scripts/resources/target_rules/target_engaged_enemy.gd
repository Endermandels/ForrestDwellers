extends TargetRule
class_name TargetEngagedEnemy

func get_targets(stats: Stats, _units_queue: Array[Stats]) -> Array[Stats]:
    return [stats.engaged_enemy]
