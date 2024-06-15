class_name SaverLoader
extends Node

const save_file_path : String = "user://savegame.tres"

func save_game() -> void:
	var saved_game : SavedGame = SavedGame.new()
	saved_game.location_spider_unlocked_level = Globals.LOCATION_SPIDER.unlocked_level
	saved_game.location_spider_completed_level = Globals.LOCATION_SPIDER.completed_level
	saved_game.location_cyclop_unlocked_level = Globals.LOCATION_CYCLOP.unlocked_level
	saved_game.location_cyclop_completed_level = Globals.LOCATION_CYCLOP.completed_level
	saved_game.location_undead_unlocked_level = Globals.LOCATION_UNDEAD.unlocked_level
	saved_game.location_undead_completed_level = Globals.LOCATION_UNDEAD.completed_level

	saved_game.current_deck = Globals.char_stats.starting_deck.duplicate(true)
		
	ResourceSaver.save(saved_game, save_file_path)
	
func load_game() -> void:
	if ! save_file_exists():
		return

	var saved_game : SavedGame = SafeResourceLoader.load(save_file_path) as SavedGame
	if saved_game == null:
		print("Saved game was unsafe!")
		return
	
	Globals.LOCATION_SPIDER.unlocked_level = saved_game.location_spider_unlocked_level
	Globals.LOCATION_SPIDER.completed_level = saved_game.location_spider_completed_level
	Globals.LOCATION_CYCLOP.unlocked_level = saved_game.location_cyclop_unlocked_level
	Globals.LOCATION_CYCLOP.completed_level = saved_game.location_cyclop_completed_level
	Globals.LOCATION_UNDEAD.unlocked_level = saved_game.location_undead_unlocked_level
	Globals.LOCATION_UNDEAD.completed_level = saved_game.location_undead_completed_level

	Globals.char_stats.starting_deck = saved_game.current_deck
	
func delete_save() -> void:
	if save_file_exists():
		DirAccess.remove_absolute(save_file_path)
	Globals.LOCATION_SPIDER.unlocked_level = 1
	Globals.LOCATION_SPIDER.completed_level = 0
	Globals.LOCATION_CYCLOP.unlocked_level = 0
	Globals.LOCATION_CYCLOP.completed_level = 0
	Globals.LOCATION_UNDEAD.unlocked_level = 0
	Globals.LOCATION_UNDEAD.completed_level = 0
	
	var char_stats : Stats = load(Globals.CHARACTER_PATH)
	Globals.char_stats.starting_deck = char_stats.starting_deck.duplicate(true)

func save_file_exists() -> bool:
	return ResourceLoader.exists(save_file_path)
