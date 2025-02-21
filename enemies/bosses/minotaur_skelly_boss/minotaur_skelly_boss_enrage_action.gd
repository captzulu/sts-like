extends EnemyAction

@export var effects_export : Dictionary = {
	"enrage" : [4, 4, 5]
}

func setup_effects() -> void:
	var enrage_effect : EnrageEffect = EnrageEffect.new(get_effect_value(effects_export["enrage"]), sound, enemy)
	effects.append(enrage_effect)

func is_performable() -> bool:
	if not enemy or enemy.stats.get_status_stacks(Enrage) > 0:
		return false
	
	return true

func perform_action() -> void:
	if not enemy:
		return
	
	var target_array : Array[Node] = [enemy]
	var enrage_effect : EnrageEffect = effects[0]
	enrage_effect.execute(target_array)
	enemy.stats.statuses_dict[Enrage.get_identifier()].hit_this_turn = true
	
	Events.enemy_action_completed.emit(enemy)
