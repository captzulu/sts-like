class_name BattleMenu
extends CanvasLayer

@onready var main_menu : PackedScene = load("res://scenes/ui/main_menu/main_menu.tscn")
@onready var main_menu_button : Button = %MainMenuButton
@onready var restart_button : Button = %RestartBattleButton
@onready var cancel_button : Button = %CancelButton

func _ready() -> void:
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	cancel_button.pressed.connect(self.hide)

func _on_main_menu_button_pressed() -> void:
	Globals.current_location = null
	get_tree().change_scene_to_packed(main_menu)
