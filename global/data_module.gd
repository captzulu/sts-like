extends Node

static func get_files_in_folder(folder_path : String) -> Array:
	var files_in_folder : Array = []
	for file in DirAccess.get_files_at(folder_path):
		files_in_folder.append(folder_path + file)
	return files_in_folder
	
static func load_directory_resources_to_dict(directory : String) -> Dictionary:
	var dict : Dictionary
	directory = directory if directory.ends_with("/") else directory + "/"
	var resources : Array = DataModule.get_files_in_folder(directory)
	for resource in resources:
		var resource_loaded : Resource = load(resource)
		dict[resource_loaded.identifier] = resource_loaded
	return dict
	
static func open_db() -> SQLite:
	var db : SQLite = SQLite.new()
	db.path = "res://data/database.db"
	db.open_db()
	return db
