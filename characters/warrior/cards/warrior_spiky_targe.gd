extends Card
@export var spikes : int = 3  
@export var block : int = 3  

func apply_effects(targets : Array[Node], player : Player) -> void:
	var block_effect : BlockEffect = BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	block_effect.execute(targets)
	
	player.add_status(Spike.new(spikes))
