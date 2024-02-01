extends EnemyAction

@export var block : int = 6

func setup_effects() -> void:
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	effects.append(block_effect)

func perform_action() -> void:
	if not enemy or not target:
		return
	
	effects[0].execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
