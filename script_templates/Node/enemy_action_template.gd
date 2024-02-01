# meta-name: EnemyAction
# meta-description: An action whcih can be performed by an enemy during its turn.
extends EnemyAction

@export var export_var := 0

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT)
	var start : Vector2 = enemy.global_position
	var end : Vector2 = target.global_position + Vector2.RIGHT * 32

	tween.finished.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
