extends Card

@export var effects : Dictionary = {
	"block" : 5
}

func apply_effects(targets : Array[Node], _player : Player) -> void:
	var block_effect : BlockEffect = BlockEffect.new(effects["block"], sound)
	block_effect.execute(targets)
	
