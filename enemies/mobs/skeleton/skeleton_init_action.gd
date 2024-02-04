extends EnemyAction

@export var endure_stacks : int = 2

func setup_effects() -> void:
	var endure_effect := EndureEffect.new(endure_stacks, sound, enemy)
	effects.append(endure_effect)

func perform_action() -> void:
	if not enemy:
		return
	
	effects[0].execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
