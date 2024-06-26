class_name Charge
extends Status

var type : Type = Type.BUFF
const identifier : String = "Charge"
const icon_path : String = "res://art/charge.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)

func generate_tooltip() -> String:
	return "Take [color=\"62c223\"]%s[/color] damage at the end of the player's 
		turn. Then decreases by 1." % str(stacks)
