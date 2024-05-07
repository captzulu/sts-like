class_name BattleOverPanel
extends Panel

enum Type{WIN, LOSE}
var card_reward : PackedScene = preload("res://scenes/ui/card_reward_ui.tscn")

@onready var label : Label = %Label
@onready var continue_button : Button = %ContinueButton
@onready var restart_button : Button = %RestartButton

func _ready() -> void:
	continue_button.pressed.connect(_on_continue_button_pressed)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	Events.battle_over_screen_requested.connect(show_screen)
	
func show_screen(text : String, type: Type) -> void:
	label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	show()
	get_tree().paused = true

func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(card_reward)
