extends Card 
@export var effects : Dictionary = {
	"restrained" : 2,
	"damage" : 3,
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	damage_effect.execute(targets)
	
	for enemy in targets:
		var restrained : Restrained = Restrained.new(effects["restrained"])
		restrained.add_to(enemy)
