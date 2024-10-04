class_name CyclopEnrage
extends Status

var type : Type = Type.BUFF
const identifier = "Cyclop_Enrage"
const icon_path : String = "res://art/enrage.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)

func generate_tooltip() -> String:
	return "When Cyclop has [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]" +  str(stacks) + "[/color] HP or less his attack becomes much stronger."

