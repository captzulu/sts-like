extends EnemyAction

@export var effects_export : Dictionary = {
}

func setup_effects() -> void:
	pass

func perform_action() -> void:
	if not enemy:
		return
	var status : Status = SkeletonSwarm.new(1)
	enemy.add_status(status)
