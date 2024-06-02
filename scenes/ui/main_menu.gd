class_name MainMenu
extends CanvasLayer

@onready var saver_loader : SaverLoader = %SaverLoader
@onready var card_pile_display : CardPileDisplay = %CardPileDisplay as CardPileDisplay
@onready var see_deck_button : Button = %SeeDeckPileButton

var battle : PackedScene = preload("res://scenes/battle/battle.tscn")

func _ready() -> void:
	%SaveButton.pressed.connect(saver_loader.save_game)
	%LoadButton.pressed.connect(saver_loader.load_game)
	see_deck_button.pressed.connect(open_deck_display)
	%SpiderCavernButton.pressed.connect(_on_spider_cavern_pressed)
	%CyclopMountainButton.pressed.connect(_on_cyclop_mountain_button_pressed)
	%UndeadLairButton.pressed.connect(_on_undead_lair_button_pressed)
	saver_loader.game_loaded.connect(check_unlock_buttons)
	check_unlock_buttons()
	
func _on_spider_cavern_pressed() -> void:
	enter_map(Globals.LOCATION_SPIDER)

func _on_cyclop_mountain_button_pressed() -> void:
	enter_map(Globals.LOCATION_CYCLOP)

func _on_undead_lair_button_pressed() -> void:
	enter_map(Globals.LOCATION_UNDEAD)

func enter_map(new_map : Location) -> void:
	if new_map.unlocked_level > 0:
		Globals.current_location = new_map
		get_tree().change_scene_to_packed(battle)
		
func check_unlock_buttons() -> void: 
	if saver_loader.save_file_exists():
		%LoadButton.disabled = false
	%SpiderCavernButton.disabled = Globals.LOCATION_SPIDER.unlocked == 0
	%CyclopMountainButton.disabled = Globals.LOCATION_CYCLOP.unlocked == 0
	%UndeadLairButton.disabled = Globals.LOCATION_UNDEAD.unlocked == 0
	
func open_deck_display() -> void:
	card_pile_display.open(Globals.char_stats.starting_deck, "Deck :")


