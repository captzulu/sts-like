extends EnemyAction

@export var effects_export : Dictionary = {
	"hp_threshold" : [7, 9, 11]
}

func setup_effects() -> void:
	pass

func perform_action() -> void:
	if not enemy:
		return
	var status : Status = CyclopEnrage.new(get_effect_value(effects_export["hp_threshold"]))
	enemy.add_status(status)
