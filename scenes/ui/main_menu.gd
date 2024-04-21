class_name MainMenu
extends CanvasLayer

var battle : PackedScene = preload("res://scenes/battle/battle.tscn")

func _ready() -> void:
	var new_char = load("res://characters/warrior/warrior.tres")
	Globals.char_stats = new_char.create_instance()
	%SpiderCavernButton.pressed.connect(_on_spider_cavern_pressed)
	%CyclopMountainButton.pressed.connect(_on_cyclop_mountain_button_pressed)
	%UndeadLairButton.pressed.connect(_on_undead_lair_button_pressed)
	
func _on_spider_cavern_pressed() -> void:
	Globals.current_location = Globals.LOCATION_SPIDER
	get_tree().change_scene_to_packed(battle)

func _on_cyclop_mountain_button_pressed() -> void:
	Globals.current_location = Globals.LOCATION_CYCLOP
	get_tree().change_scene_to_packed(battle)

func _on_undead_lair_button_pressed() -> void:
	Globals.current_location = Globals.LOCATION_UNDEAD
	get_tree().change_scene_to_packed(battle)
