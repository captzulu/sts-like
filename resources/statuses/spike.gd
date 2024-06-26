class_name Spike
extends Status

var type : Type = Type.BUFF
const identifier : String = "Spike"
const icon_path : String = "res://art/original_art/spike.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)
	Events.player_turn_started.connect(_on_player_turn_started)

func generate_tooltip() -> String:
	var template : String = "Deal [color=\"" + Globals.TOOLTIP_SPIKE_TEXT_COLOR + "\"]%s[/color] damage to the enemy when attacked. Decreases by [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]1/3rd[/color] on turn end."
	return template % str(stacks)

func _on_player_turn_started() -> void:
	decrease_stacks(round(stacks / 3))
