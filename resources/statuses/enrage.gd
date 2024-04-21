class_name Enrage
extends Status

var type : Type = Type.BUFF
const identifier = "Enrage"
const icon_path : String = "res://art/enrage.png"
const damage_multiplier : int = 25

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)
	Events.player_turn_started.connect(_on_player_turn_started)

func generate_tooltip() -> String:
	return "Take [color=\"62c223\"]%s[/color] damage at the end of the player's turn. Then decreases by 1." % str(stacks)

func _on_player_turn_started() -> void:
	decrease_stacks(1)
