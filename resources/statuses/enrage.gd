class_name Enrage
extends Status

var type : Type = Type.BUFF
const identifier = "Enrage"
const icon_path : String = "res://art/enrage.png"
const damage_multiplier : int = 10
var hit_this_turn : bool = false

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)
	Events.player_turn_started.connect(_on_player_turn_started)
	Events.wave_spawned.connect(_on_wave_spawned)

func is_being_hit() -> void:
	hit_this_turn = true
	stacks += 1

func get_damage_multiplier() -> int:
	return damage_multiplier * stacks

func generate_tooltip() -> String:
	return "Increases damage by [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]10%[/color] per stack. Gain a stack everytime you lose HP. Lose on turn start [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]unless[/color] damage was taken [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]or[/color] a wave was cleared last turn."

func _on_player_turn_started() -> void:
	if hit_this_turn == false:
		decrease_stacks(stacks)
	hit_this_turn = false

func _on_wave_spawned(_wave_number : int) -> void:
	hit_this_turn = true
