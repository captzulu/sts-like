extends Card

@export var effects : Dictionary = {
	"damage" : 4,
	"poison" : 5
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	damage_effect.execute(targets)
	for enemy in targets:
		var poison : Poison = Poison.new(effects["poison"])
		poison.add_to(enemy)
