class_name Renew
extends Status

var type : Type = Type.BUFF
const identifier : String = "Renew"
const icon_path : String = "res://art/renew.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)
	Events.player_turn_started.connect(_on_player_turn_started)

func generate_tooltip() -> String:
	return "Heal [color=\"" + Globals.TOOLTIP_HEAL_TEXT_COLOR + "\"]%s[/color] HP on end turn, decrease by [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]1[/color]." % str(stacks)

func _on_player_turn_started() -> void:
	is_on.stats.heal(stacks)
	decrease_stacks(1)
