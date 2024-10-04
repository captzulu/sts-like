extends EnemyAction

@export var effects_export : Dictionary = {
	"hp_threshold" : [15, 20, 25]
}

func setup_effects() -> void:
	pass

func perform_action() -> void:
	if not enemy:
		return
	var status = CyclopEnrage.new(get_effect_value(effects_export["hp_threshold"]))
	enemy.add_status(status)
