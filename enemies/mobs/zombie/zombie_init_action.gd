extends EnemyAction

@export var effects_export : Dictionary = {
	"undying_stacks" : [1, 1, 1]
}

func setup_effects() -> void:
	var undying_effect : UndyingEffect = UndyingEffect.new(get_effect_value(effects_export["undying_stacks"]), sound, enemy)
	effects.append(undying_effect)

func perform_action() -> void:
	if not enemy:
		return
	
	effects[0].execute([enemy])
