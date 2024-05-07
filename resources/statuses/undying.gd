class_name Undying
extends Status

var type : Type = Type.BUFF
const identifier : String = "Undying"
const icon_path : String = "res://art/undying.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)

func generate_tooltip() -> String:
	return "Prevents death [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]%s[/color] times." % str(stacks)
