class_name MainMenu
extends CanvasLayer

@onready var saver_loader : SaverLoader = %SaverLoader

var battle : PackedScene = preload("res://scenes/battle/battle.tscn")

func _ready() -> void:
	%SaveButton.pressed.connect(saver_loader.save_game)
	%LoadButton.pressed.connect(saver_loader.load_game)
	%SpiderCavernButton.pressed.connect(_on_spider_cavern_pressed)
	%CyclopMountainButton.pressed.connect(_on_cyclop_mountain_button_pressed)
	%UndeadLairButton.pressed.connect(_on_undead_lair_button_pressed)
	saver_loader.game_loaded.connect(check_unlock_buttons)
	if saver_loader.save_file_exists():
		check_unlock_buttons()
	
func _on_spider_cavern_pressed() -> void:
	enter_map(Globals.LOCATION_SPIDER)

func _on_cyclop_mountain_button_pressed() -> void:
	enter_map(Globals.LOCATION_CYCLOP)

func _on_undead_lair_button_pressed() -> void:
	enter_map(Globals.LOCATION_UNDEAD)

func enter_map(new_map : Location) -> void:
	if new_map.unlocked == true:
		Globals.current_location = new_map
		get_tree().change_scene_to_packed(battle)
		
func check_unlock_buttons() -> void: 
	%LoadButton.disabled = false
	%SpiderCavernButton.disabled = ! Globals.LOCATION_SPIDER.unlocked
	%CyclopMountainButton.disabled = ! Globals.LOCATION_CYCLOP.unlocked
	%UndeadLairButton.disabled = ! Globals.LOCATION_UNDEAD.unlocked


