extends Card

@export var effects : Dictionary = {
	"damage" : 21
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"]/targets.size(), sound, player)
	damage_effect.execute(targets)

func get_total_damage_on_targets(targets : Array[Node], player: Player):
	return DamageEffect.new(effects["damage"]/targets.size(), sound, player).final_damage
