class_name Poison
extends Status

var type : Type = Type.DEBUFF
const identifier : String = "Poison"
const icon_path : String = "res://art/original_art/tile_0114.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)
	Events.player_turn_ended.connect(_on_player_turn_ended)

func generate_tooltip() -> String:
	return "Take [color=\"62c223\"]%s[/color] damage at the end of the player's 
		turn. Then decreases by 1." % str(stacks)

func _on_player_turn_ended() -> void:
	is_on.take_damage(stacks, true)
	decrease_stacks(1)
