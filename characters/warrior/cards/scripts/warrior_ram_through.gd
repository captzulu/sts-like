extends Card

@export var effects : Dictionary = {
	"damage" : 5
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage : int = effects["damage"]
	if targets[0].stats.get_status_stacks(Restrained) > 0:	
		damage = damage * 2
		player.stats.mana += 1
	var damage_effect : DamageEffect = DamageEffect.new(damage, sound, player)
	damage_effect.execute(targets)
