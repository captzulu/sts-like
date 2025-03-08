extends Node

func _init() -> void:
	var new_char : CharacterStats = load(Globals.CHARACTER_PATH)
	Globals.char_stats = new_char.create_instance()
	Globals.reward_cards.merge(DataModule.load_directory_resources_to_dict("res://characters/warrior/cards/rewards"))
	load_config()

func load_config() -> void:
	Globals.CONFIG = ConfigFile.new()
	Globals.CONFIG.load(Globals.CONFIG_PATH)
	var SFX_volume = Globals.CONFIG.get_value('audio', 'SFX', 0.75)
	var music_volume = Globals.CONFIG.get_value('audio', 'Music', 0.75)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('SFX'), linear_to_db(SFX_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Music'), linear_to_db(music_volume))
	
func _ready() -> void:
	return
	for location in Globals.DATA:
		print(location + " :")
		for wave in Globals.DATA[location]:
			var line = str(wave) + " : "
			for difficulty in [0,1,2]:
				line += str(calculate_wave_hp(Globals.DATA[location][wave].values(), difficulty)) + " | "
			print(line)
		print()

func calculate_wave_hp(enemy_names : Array, difficulty : int) -> float:
	var mobs_directory : String = "res://enemies/mobs"
	var boss_directory : String = "res://enemies/bosses"
	var enemies : Dictionary = {}
	enemies.merge(DataModule.load_directory_resources_to_dict(mobs_directory))
	enemies.merge(DataModule.load_directory_resources_to_dict(boss_directory))
	var enemy_hp : Array[int] = []
	for enemy in enemy_names:
		if enemy is int or enemy.length() < 1:
			continue
		var enemy_stats : Stats = enemies[enemy]
		enemy_hp.append(enemy_stats.max_health_difficulty[difficulty])
	return enemy_hp.reduce(sum)

func sum(accum : int, number : int) -> int:
	return accum + number
