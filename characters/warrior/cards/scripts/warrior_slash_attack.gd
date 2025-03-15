extends Card

@export var effects : Dictionary = {
	"damage" : 6
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	damage_effect.execute(targets)

func get_total_damage_on_targets(targets : Array[Node], player : Player):
	var damage : int = effects["damage"] 
	return DamageEffect.new(damage, sound, player).final_damage * targets.size()
