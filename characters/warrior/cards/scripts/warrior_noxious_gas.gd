extends Card

@export var effects : Dictionary = {}

func apply_effects(targets : Array[Node], _player : Player) -> void:
	var enemy_most_poisoned : Enemy = null
	for enemy in targets:
		if not enemy_most_poisoned or enemy_most_poisoned.stats.get_status_stacks(Poison) < enemy.stats.get_status_stacks(Poison):
			enemy_most_poisoned = enemy

	var original_targets : Array = targets.duplicate()
	if (enemy_most_poisoned.stats.get_status_stacks(Poison) > 0):
		targets.erase(enemy_most_poisoned)
		for enemy in targets:
			var poison : Poison = Poison.new(enemy_most_poisoned.stats.get_status_stacks(Poison))
			poison.add_to(enemy)
		
	for enemy : Enemy in original_targets:
		var poison : Poison = enemy.stats.get_status(Poison)
		enemy.take_damage(poison.stacks, true)
		poison.decrease_stacks(1)
