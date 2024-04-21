class_name Stoneskin
extends Status

var type : Type = Type.BUFF
const identifier : String = "Stoneskin"
const icon_path : String = "res://art/stoneskin.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)
	Events.player_turn_started.connect(_on_player_turn_started)

func generate_tooltip() -> String:
	var template : String = "Gain [color=\"" + Globals.TOOLTIP_BLOCK_TEXT_COLOR + "\"]%s[/color] block at the start of the player's turn. Then decreases by [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]1[/color]."
	return template % str(stacks)

func _on_player_turn_started() -> void:
	is_on.stats.block += stacks
	decrease_stacks(1)
