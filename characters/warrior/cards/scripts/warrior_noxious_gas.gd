extends Card

@export var effects : Dictionary = {}

func apply_effects(targets : Array[Node], player : Player) -> void:
	var enemy_most_poisoned : Enemy = null
	for enemy in targets:
		if not enemy_most_poisoned or enemy_most_poisoned.stats.get_status_count(Poison) < enemy.stats.get_status_count(Poison):
			enemy_most_poisoned = enemy

	var original_targets : Array = targets.duplicate()
	if (enemy_most_poisoned.stats.get_status_count(Poison) > 0):
		targets.erase(enemy_most_poisoned)
		for enemy in targets:
			var poison : Poison = Poison.new(enemy_most_poisoned.stats.get_status_count(Poison))
			poison.add_to(enemy)
		
	for enemy in original_targets:
		enemy.take_damage(enemy.stats.get_status_count(Poison))
