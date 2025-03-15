extends Card

@export var effects : Dictionary = {
	"damage" : 4
}

func apply_effects(targets : Array[Node], player : Player) -> void:
	has_no_animation = false
	var damage_effect : DamageEffect = DamageEffect.new(effects["damage"], sound, player)
	var enrage_stacks : int = player.get_status_stacks(Enrage.get_identifier())
	var number_of_strikes : int = 1 + (enrage_stacks / 2)
	var target : Node
	var tree : SceneTree = targets[0].get_tree()
	for i in range(number_of_strikes):
		var remaining_targets : Array[Node] = targets.filter(not_null)
		if remaining_targets.size() > 0:
			target = remaining_targets[randi_range(0, remaining_targets.size() - 1)]
			damage_effect.execute([target])
			await tree.create_timer(0.35, false).timeout
	Events.card_play_animation_finished.emit(self)

func not_null(value : Variant) -> bool:
	return is_instance_valid(value)

func get_total_damage(player : Player) -> int:
	var enrage_stacks : int = player.get_status_stacks(Enrage.get_identifier())
	var number_of_strikes : int = 1 + (enrage_stacks / 2)
	return DamageEffect.new(effects["damage"] * number_of_strikes, sound, player).final_damage
