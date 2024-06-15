extends Node

func _init() -> void:
	var new_char : CharacterStats = load(Globals.CHARACTER_PATH)
	Globals.char_stats = new_char.create_instance()
	Globals.reward_cards.merge(DataModule.FILE_MANAGER.load_directory_resources_to_dict("res://characters/warrior/cards/rewards"))
