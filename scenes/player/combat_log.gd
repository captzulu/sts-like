class_name CombatLog
extends Node

var turn : int = 0
var first_line_in_turn : bool = true
	
func _init() -> void:
	Events.player_turn_started.connect(on_player_turn_start)
	
func new_line(line : String) -> void:
	if first_line_in_turn:
		Events.combat_log_updated.emit("\n[u]Turn #%s[/u]" % str(turn))
		first_line_in_turn = false
	Events.combat_log_updated.emit(line)
	
func on_player_turn_start():
	turn += 1
	first_line_in_turn = true
	
func log_heal(amount : int, reason : String) -> void:
	var line : String = "Heal [color=\"" + Globals.TOOLTIP_HEAL_TEXT_COLOR + "\"]%s[/color] from [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]%s[/color]"
	new_line(line % [str(amount), reason])

func log_damage(amount : int) -> void:
	new_line("[color=\"" + Globals.TOOLTIP_DAMAGE_TEXT_COLOR + "\"]%s[/color] damage taken" % str(amount))
