class_name SaverLoader
extends Node

const save_file_path : String = "user://savegame.tres"

signal game_loaded

func save_game() -> void:
	var saved_game : SavedGame = SavedGame.new()
	saved_game.location_spider_unlocked = Globals.LOCATION_SPIDER.unlocked
	saved_game.location_spider_completed = Globals.LOCATION_SPIDER.completed
	saved_game.location_cyclop_unlocked = Globals.LOCATION_CYCLOP.unlocked
	saved_game.location_cyclop_completed = Globals.LOCATION_CYCLOP.completed
	saved_game.location_undead_unlocked = Globals.LOCATION_UNDEAD.unlocked
	saved_game.location_undead_completed = Globals.LOCATION_UNDEAD.completed

	saved_game.current_deck = Globals.char_stats.starting_deck.duplicate(true)
		
	ResourceSaver.save(saved_game, save_file_path)
	
func load_game() -> void:
	var saved_game : SavedGame = SafeResourceLoader.load(save_file_path) as SavedGame
	
	if saved_game == null:
		print("Saved game was unsafe!")
		return
	
	Globals.LOCATION_SPIDER.unlocked = saved_game.location_spider_unlocked
	Globals.LOCATION_SPIDER.completed = saved_game.location_spider_completed
	Globals.LOCATION_CYCLOP.unlocked = saved_game.location_cyclop_unlocked
	Globals.LOCATION_CYCLOP.completed = saved_game.location_cyclop_completed
	Globals.LOCATION_UNDEAD.unlocked = saved_game.location_undead_unlocked
	Globals.LOCATION_UNDEAD.completed = saved_game.location_undead_completed

	Globals.char_stats.starting_deck = saved_game.current_deck
	game_loaded.emit()

func save_file_exists() -> bool:
	return ResourceLoader.exists(save_file_path)
