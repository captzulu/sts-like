extends RefCounted

const CONSTANTS = preload("./constants.gd")
const DATA_COMPILER = preload("./data_compiler.gd")
	
static func get_files_in_folder(folder_path : String) -> Array:
	var files_in_folder : Array = []
	for file in DirAccess.get_files_at(folder_path):
		files_in_folder.append(folder_path + file)
	return files_in_folder

static func save_text_file(file_path_and_name : String, text : String) -> void:
	var file : FileAccess = FileAccess.open(file_path_and_name, FileAccess.WRITE)
	file.store_string(text)
	file.close()

static func load_text_file(file_path_and_name : String) -> String:
	var text : String = FileAccess.open(file_path_and_name, FileAccess.READ).get_as_text()
	return text

static func file_exists(path : String) -> bool:
	if FileAccess.file_exists(path):
		return true
	
	printerr("data_file_module: File does not exist! path: ", path)
	return false

static func encode_data_file(file_path_and_name : String) -> void:
	if !file_exists(file_path_and_name):
		return
	
	var load_file_data : String = FileAccess.open(file_path_and_name, FileAccess.READ).get_as_text()
	var save_file_path : String = file_path_and_name.replace(CONSTANTS.FORMAT_DATA_FILE, CONSTANTS.FORMAT_ENCODED_DATA_FILE)
 
	save_text_file(save_file_path, DATA_COMPILER.encode_data_to_string(load_file_data))
	
static func load_directory_resources_to_dict(directory : String) -> Dictionary:
	var dict : Dictionary
	directory = directory if directory.ends_with("/") else directory + "/"
	var resources : Array = DataModule.FILE_MANAGER.get_files_in_folder(directory)
	for resource in resources:
		var resource_loaded : Resource = load(resource)
		dict[resource_loaded.identifier] = resource_loaded
	return dict
