class_name Renew
extends Status

var type : Type = Type.BUFF
const identifier = "Renew"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload("res://art/renew.png")
	Events.player_turn_started.connect(_on_player_turn_started)

func generate_tooltip() -> String:
	return "Take [color=\"62c223\"]%s[/color] damage at the end of the player's 
		turn. Then decreases by 1." % str(stacks)

func _on_player_turn_started() -> void:
	is_on.stats.heal(stacks)
	stacks -= 1
