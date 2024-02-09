extends EnemyAction

@export var restrained : int = 4
@export var damage : int = 4

var restrained_effect : RestrainedEffect
var damage_effect : DamageEffect

func setup_effects() -> void:
	restrained_effect = RestrainedEffect.new(restrained, sound, enemy)
	damage_effect = DamageEffect.new(damage, sound, enemy)
	effects.append(restrained_effect)
	effects.append(damage_effect)

func perform_action() -> void:
	if not enemy or not target:
		return
	
	
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT)
	var start : Vector2 = enemy.global_position
	var end : Vector2 = target.global_position + Vector2.RIGHT * 32
	var target_array : Array[Node] = [target]
	
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	restrained_effect.execute([target])
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	
	tween.finished.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
