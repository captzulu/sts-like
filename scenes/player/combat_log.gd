class_name CombatLog
extends Node

var lines : Array[String] = []
var turn : int = 0
	
func _init() -> void:
	Events.player_turn_started.connect(on_player_turn_start)
	
func new_line(line : String) -> void:
	lines.append(line)
	Events.combat_log_updated.emit(line)
	
func on_player_turn_start():
	turn += 1
	new_line("Turn #%s:" % str(turn))
	
func log_heal(amount : int, reason : String) -> void:
	var line : String = "Heal [color=\"" + Globals.TOOLTIP_HEAL_TEXT_COLOR + "\"]%s[/color] from [color=\"" + Globals.TOOLTIP_HIGHLIGHT_TEXT_COLOR + "\"]%s[/color]"
	new_line(line % [str(amount), reason])

func log_damage(amount : int) -> void:
	new_line("Take [color=\"" + Globals.TOOLTIP_DAMAGE_TEXT_COLOR + "\"]%s[/color] damage " % str(amount))
	
func print_lines() -> String:
	var return_string : String = "" 
	for line in lines:
		return_string += line + "\n"
	return return_string
