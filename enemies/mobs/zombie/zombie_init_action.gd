extends EnemyAction

@export var undying_stacks : int = 2

func setup_effects() -> void:
	var undying_effect := UndyingEffect.new(undying_stacks, sound, enemy)
	effects.append(undying_effect)

func perform_action() -> void:
	if not enemy:
		return
	
	effects[0].execute([enemy])
