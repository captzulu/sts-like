class_name MainMenu
extends CanvasLayer

var battle : PackedScene = preload("res://scenes/battle/battle.tscn")

func _ready() -> void:
	
	if Globals.LOCATION_SPIDER.unlocked == true:
		%SpiderCavernButton.pressed.connect(_on_spider_cavern_pressed)
	else:
		%SpiderCavernButton.disabled = true
		
	if Globals.LOCATION_CYCLOP.unlocked == true:
		%CyclopMountainButton.pressed.connect(_on_cyclop_mountain_button_pressed)
	else:
		%CyclopMountainButton.disabled = true
		
	if Globals.LOCATION_UNDEAD.unlocked == true:
		%UndeadLairButton.pressed.connect(_on_undead_lair_button_pressed)
	else:
		%UndeadLairButton.disabled = true
	
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
