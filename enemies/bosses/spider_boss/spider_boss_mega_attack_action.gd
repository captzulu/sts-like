extends EnemyAction

@export var poison : int = 8
@export var on_turn : int = 2

func is_performable() -> bool:
	if not enemy or enemy.turn_alive != on_turn:
		return false
	
	return true

func setup_effects() -> void:
	var poison_effect : PoisonEffect = PoisonEffect.new(poison, sound, enemy)
	effects.append(poison_effect)

func perform_action() -> void:
	if not enemy or not target:
		return
	var tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT)
	var start : Vector2 = enemy.global_position
	var end : Vector2 = target.global_position + Vector2.RIGHT * 32
	var target_array : Array[Node] = [target]
	
	var poison_effect := effects[0]
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(poison_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
