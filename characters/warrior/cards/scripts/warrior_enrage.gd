extends Card 
@export var effects : Dictionary = {
	"enrage" : 3,
	"block" : 3,
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var block_effect : BlockEffect = BlockEffect.new()
	block_effect.amount = effects["block"]
	block_effect.sound = sound
	block_effect.execute(targets)
	
	player.add_status(Enrage.new(effects["enrage"]))
