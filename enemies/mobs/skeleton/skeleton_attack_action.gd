extends EnemyAction

@export var effects_export : Dictionary = {
	"damage" : [4, 7, 11],
	"swarm_bonus" : [2, 3, 3]
}

func setup_effects() -> void:
	Events.wave_spawned.connect(on_wave_spawned)
	Events.enemy_death.connect(on_enemy_death)
	var damage_effect : DamageEffect = DamageEffect.new(get_effect_value(effects_export["damage"]), sound, enemy)
	effects.append(damage_effect)

func on_wave_spawned(_wave_index : int) -> void:
	var skelly_count_dmg : int = 0
	var allies : Array[Node] = enemy.get_tree().get_nodes_in_group("enemies")
	for ally in allies:
		if ally.stats.identifier == "skeleton":
			skelly_count_dmg += get_effect_value(effects_export["swarm_bonus"])
	effects[0] = DamageEffect.new(get_effect_value(effects_export["damage"]) + skelly_count_dmg, sound, enemy)

func on_enemy_death(dead_enemy : Enemy) -> void:
	if dead_enemy.stats.identifier == "skeleton":
		effects[0] = DamageEffect.new(effects[0].amount - get_effect_value(effects_export["swarm_bonus"]), sound, enemy)
		enemy.update_action()

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
