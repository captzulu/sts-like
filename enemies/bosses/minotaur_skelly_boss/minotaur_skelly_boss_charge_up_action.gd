extends EnemyAction

var charge_up_effect : ChargeUpEffect

func setup_effects() -> void:
	charge_up_effect = ChargeUpEffect.new(1, sound, enemy)
	effects.append(charge_up_effect)

func perform_action() -> void:
	charge_up_effect.execute([enemy])
	Events.enemy_action_completed.emit(enemy)
