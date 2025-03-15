extends Card

@export var effects : Dictionary = {
	"damage" : 5,
	"damage_spike" : 2,
	"spikes" : 1,
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	Spike.new(effects["spikes"]).add_to(player)
	var spike_damage : int = player.get_spikes() * effects["damage_spike"]
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"] + spike_damage, sound, player)
	damage_effect.execute(targets)

func get_total_damage(player : Player) -> int:
	var spike_stacks : int = player.stats.get_status_stacks(Spike) + self.effects["spikes"]
	var damage_spike : int = self.effects["damage_spike"] * spike_stacks
	var damage_effect : DamageEffect = DamageEffect.new(damage_spike + self.effects["damage"], sound, player)
	return damage_effect.final_damage
