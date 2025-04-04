extends Card

@export var effects : Dictionary = {
	"damage" : 6
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var target_block : int = targets[0].stats.block
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"] + (target_block * 2), sound, player)
	damage_effect.execute(targets)

func get_total_damage_on_targets(targets : Array[Node], player: Player):
	var target_block : int = targets[0].stats.block
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"] + (target_block * 2), sound, player)
	return damage_effect.final_damage
