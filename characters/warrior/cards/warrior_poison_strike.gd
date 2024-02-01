extends Card

@export var damage : int = 4

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(damage, sound, player)
	damage_effect.execute(targets)
	for enemy in targets:
		var poison : Poison = Poison.new(5)
		poison.add_to(enemy)
