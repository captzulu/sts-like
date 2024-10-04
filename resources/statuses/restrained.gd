class_name Restrained
extends Status

var type : Type = Type.DEBUFF
const identifier = "Restrained"
const icon_path : String = "res://art/restrained.png"
const damage_multiplier : int = -33

static func get_identifier() -> String:
	return identifier
	
func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)
	if is_on is Player:
		Events.player_turn_ended.connect(_on_player_turn_ended)
	
	if is_on is Enemy:
		Events.enemy_turn_ended.connect(_on_enemy_turn_ended)

func generate_tooltip() -> String:
	return "Reduces damage by [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]33%[/color] for the next [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]%s[/color] turns" % str(stacks)

func _on_player_turn_ended() -> void:
	decrease_stacks(1)

func _on_enemy_turn_ended() -> void:
	decrease_stacks(1)
