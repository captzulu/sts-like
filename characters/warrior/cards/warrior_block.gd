extends Card

func apply_effects(targets : Array[Node], _player : Player) -> void:
	var block_effect : BlockEffect = BlockEffect.new()
	block_effect.amount = 5
	block_effect.sound = sound
	block_effect.execute(targets)
	
