extends EnemyAction

@export var stoneskin : int = 4
@export var effects_export : Dictionary = {
	"stoneskin" : 6
}

func setup_effects() -> void:
	var stoneskin_effect : StoneskinEffect = StoneskinEffect.new(effects_export["stoneskin"], sound, enemy)
	effects.append(stoneskin_effect)

func perform_action() -> void:
	if not enemy:
		return

	target = enemy
	var lowest_hp : int = 101
	var allies : Array[Node] = enemy.get_tree().get_nodes_in_group("enemies")
	for ally in allies:
		if ally.stats.get_status_count(Renew) > 0:
			continue
		var hp_percent : int = calculate_health_percent(ally.stats)
		if hp_percent < lowest_hp:
			lowest_hp = hp_percent
			target = ally

	var target_array : Array[Node] = [target]
	
	var stoneskin_effect : StoneskinEffect = effects[0]
	stoneskin_effect.execute(target_array)
	
	Events.enemy_action_completed.emit(enemy)
