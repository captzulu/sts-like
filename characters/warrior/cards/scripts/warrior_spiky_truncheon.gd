extends Card

@export var effects : Dictionary = {
	"damage" : 6
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var spike_damage : int = player.get_spikes() * 2
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"] + spike_damage, sound, player)
	damage_effect.execute(targets)
