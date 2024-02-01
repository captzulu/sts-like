extends Card

@export var damage : int = 6

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(damage, sound, player)
	damage_effect.execute(targets)
