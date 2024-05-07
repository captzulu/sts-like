class_name Card
extends Resource

enum Type {ATTACK, SKILL, POWER}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

@export_group("Card Attributes")
@export var identifier : String
@export var type : Type
@export var target : Target
@export var cost : int

@export_group("Card Visuals")
@export var icon : Texture
@export_multiline var tooltip_text_template : String
@export var sound : AudioStream

var animation_playing : bool = false
var has_no_animation : bool = true

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY
	
func _get_targets(targets : Array[Node]) -> Array[Node]:
	if not targets:
		return []
	
	var tree : SceneTree = targets[0].get_tree()
	
	match target:
		Target.SINGLE_ENEMY:
			return [targets[0]]
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("enemies") + tree.get_nodes_in_group("player")
		_:
			return []

func play(targets : Array[Node], player: Player) -> void:
	Events.card_played.emit(self)
	player.stats.mana -= cost
	apply_effects(_get_targets(targets), player)
	await player.get_tree().create_timer(0.25).timeout
	if has_no_animation:
		Events.card_play_animation_finished.emit(self)

func apply_effects(_targets : Array[Node], _player : Player) -> void:
	pass
