extends Card

@export var effects : Dictionary = {
	"damage" : 6
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	damage_effect.execute(targets)
