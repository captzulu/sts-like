extends Card 
@export var effects : Dictionary = {
	"spikes" : 3,
	"block" : 3,
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var block_effect : BlockEffect = BlockEffect.new(effects["block"], sound)
	block_effect.execute(targets)
	
	Spike.new(effects["spikes"]).add_to(player)
