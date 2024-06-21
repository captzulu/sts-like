extends EnemyAction

@export var effects_export : Dictionary = {
	"block" : [14, 16, 18],
	"hp_threshold" : [6, 7, 8]
}

var already_used : bool = false

func is_performable() -> bool:
	if not enemy or already_used or enemy.stats.health > effects_export["hp_threshold"]:
		return false
	
	already_used = true
	return true
	
func setup_effects() -> void:
	var block_effect := BlockEffect.new(effects_export["block"], sound)
	effects.append(block_effect)
	
func perform_action() -> void:
	if not enemy or not target:
		return
	
	effects[0].execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
