extends Card

@export var effects : Dictionary = {
	"damage" : 20
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"]/targets.size(), sound, player)
	damage_effect.execute(targets)
