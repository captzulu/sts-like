extends Card

@export var effects : Dictionary = {
	"damage" : 10
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	if targets[0].stats.health < effects["damage"]:
		damage_effect.damage = targets[0].stats.health
	damage_effect.execute(targets)
