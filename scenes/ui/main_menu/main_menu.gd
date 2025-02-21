class_name MainMenu
extends CanvasLayer

@export var music : AudioStream

@onready var saver_loader : SaverLoader = %SaverLoader
@onready var card_pile_display : CardPileDisplay = %CardPileDisplay as CardPileDisplay
@onready var settings_display : CanvasLayer = %SettingsDisplay
@onready var see_deck_button : Button = %SeeDeckPileButton
@onready var see_setting_button : Button = %SeeSettingButton
@onready var location_container = %LocationContainer

var battle : PackedScene = preload("res://scenes/battle/battle.tscn")
var location_ui_scene : PackedScene = preload("res://scenes/ui/main_menu/location_ui.tscn")

func _ready() -> void:
	if ! Globals.game_loaded:
		saver_loader.load_game()
		Globals.game_loaded = true
	saver_loader.save_game()
	reload_locations()
	MusicPlayer.play(music, true, true)
	%NewRunButton.pressed.connect(abandon_run)
	%ExitButton.pressed.connect(_exit_button_pressed)
	see_deck_button.pressed.connect(open_deck_display)
	see_setting_button.pressed.connect(open_setting_display)

func reload_locations() -> void:
	for location in location_container.get_children():
		location_container.remove_child(location)
	create_locations()

func abandon_run() -> void:
	saver_loader.delete_save()
	get_tree().reload_current_scene()

func enter_location() -> void:
	get_tree().change_scene_to_packed(battle)

func _exit_button_pressed() -> void:
	get_tree().quit()
	
func open_deck_display() -> void:
	card_pile_display.open(Globals.char_stats.starting_deck, "Deck :")

func open_setting_display() -> void:
	settings_display.show()

func create_locations() -> void:
	for location in Globals.MAP_ORDER:
		var location_ui : LocationUi = location_ui_scene.instantiate()
		location_ui.location = location
		location_container.add_child(location_ui)
		location_ui.enter_location.connect(enter_location)
