extends EnemyAction

@export var effects_export : Dictionary = {
	"damage" : [7, 8, 9]
}

func is_performable() -> bool:
	if (
		not enemy or 
		not enemy.last_action or
		enemy.last_action.identifier != "crab_mega_block"
	):
		return false

	return true
	
func setup_effects() -> void:
	var damage_effect : DamageEffect = DamageEffect.new(get_effect_value(effects_export["damage"]), sound, enemy)
	effects.append(damage_effect)
	
func perform_action() -> void:
	if not enemy or not target:
		return
	var tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT)
	var start : Vector2 = enemy.global_position
	var end : Vector2 = target.global_position + Vector2.RIGHT * 32
	var target_array : Array[Node] = [target]
	
	var damage_effect : DamageEffect = effects[0]
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
