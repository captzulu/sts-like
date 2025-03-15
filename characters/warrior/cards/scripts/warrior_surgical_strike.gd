extends Card

@export var effects : Dictionary = {
	"damage" : 12
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var target_health : int = targets[0].stats.health
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	damage_effect.final_damage = target_health if target_health < damage_effect.final_damage else damage_effect.final_damage
	damage_effect.execute(targets)

func get_total_damage_on_targets(targets : Array[Node], player : Player):
	var target_health : int = targets[0].stats.health
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	return target_health if target_health < damage_effect.final_damage else damage_effect.final_damage
