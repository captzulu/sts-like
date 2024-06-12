class_name MainMenu
extends CanvasLayer

@onready var saver_loader : SaverLoader = %SaverLoader
@onready var card_pile_display : CardPileDisplay = %CardPileDisplay as CardPileDisplay
@onready var see_deck_button : Button = %SeeDeckPileButton
@onready var location_container = %LocationContainer

var battle : PackedScene = preload("res://scenes/battle/battle.tscn")
var location_ui_scene : PackedScene = preload("res://scenes/ui/main_menu/location_ui.tscn")

func _ready() -> void:
	create_locations()
	%SaveButton.pressed.connect(saver_loader.save_game)
	%LoadButton.pressed.connect(saver_loader.load_game)
	see_deck_button.pressed.connect(open_deck_display)
	saver_loader.game_loaded.connect(reload_scene)
	if saver_loader.save_file_exists():
		%LoadButton.disabled = false
	
func reload_scene() -> void:
	get_tree().reload_current_scene()

func enter_location() -> void:
	get_tree().change_scene_to_packed(battle)
	
func open_deck_display() -> void:
	card_pile_display.open(Globals.char_stats.starting_deck, "Deck :")

func create_locations() -> void:
	for location in Globals.MAP_ORDER:
		var location_ui : LocationUi = location_ui_scene.instantiate()
		location_ui.location = location
		location_container.add_child(location_ui)
		location_ui.enter_location.connect(enter_location)
