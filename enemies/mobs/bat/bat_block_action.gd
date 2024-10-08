extends EnemyAction

@export var effects_export : Dictionary = {
	"block" : [4,5,6]
}

func setup_effects() -> void:
	var block_effect : BlockEffect = BlockEffect.new(get_effect_value(effects_export["block"]), sound)
	effects.append(block_effect)

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect : BlockEffect = effects[0]
	block_effect.execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
