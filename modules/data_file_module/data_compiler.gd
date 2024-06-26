extends RefCounted

const CONSTANTS = preload("./constants.gd")
const FILE_MANAGER = preload("./data_file_manager.gd")

static func encode_data_to_string(text : String) -> String:
	return Marshalls.utf8_to_base64(text)

static func decode_data_to_string(text : String) -> String:
	return Marshalls.base64_to_utf8(text)
	
static func compile_data_files() -> void:
	for file in DirAccess.get_files_at(CONSTANTS.PATH_DATA_FOLDER):
		if file.ends_with(CONSTANTS.FORMAT_DATA_FILE):
			FILE_MANAGER.encode_data_file(CONSTANTS.PATH_DATA_FOLDER + file)

static func build_data_dict(dict : Dictionary) -> void:
	var dict_names : Array = dict.keys()
	
	for name in dict_names:
		for file in DirAccess.get_files_at(CONSTANTS.PATH_DATA_FOLDER):
			if file.contains(name) and file.ends_with(CONSTANTS.FORMAT_ENCODED_DATA_FILE):
				var encoded_data : String = FILE_MANAGER.load_text_file(CONSTANTS.PATH_DATA_FOLDER + file)
				var decoded_data : String = decode_data_to_string(encoded_data)
				var split_decoded_data : PackedStringArray = decoded_data.split("\n")
				dict[name] = parse_csv(split_decoded_data)
			
static func parse_csv(all_csv_lines : PackedStringArray) -> Dictionary:
	var stored_csv_dict : Dictionary = {}
	if all_csv_lines.size() <= 1:
		return stored_csv_dict
		
	var csv_headers_processed : bool = false
	var csv_line_headers : Array = []
	
	for csv_line in all_csv_lines: 
		if csv_line.is_empty():
			continue
			
		var first_char : String = csv_line[0]
		if (first_char.begins_with("#") || first_char == CONSTANTS.DELIMITER || first_char == ""):
			continue
			
		#print(">PROCESSING VALID CSV STRING LINE : ", csv_line)
		var csv_splitted_data : PackedStringArray = csv_line.split(CONSTANTS.DELIMITER)
		if !csv_headers_processed:
			csv_line_headers = process_headers(csv_splitted_data)
			csv_headers_processed = true
		else:
			add_entry(csv_splitted_data, csv_line_headers, stored_csv_dict)
				
	return stored_csv_dict
	
static func process_headers(all_headers : PackedStringArray) -> Array:
	var processed_headers : Array = []
	for header in all_headers:
		processed_headers.append(parse_cell(header))
	return processed_headers
					
static func add_entry(all_fields : PackedStringArray, headers : Array, stored_csv_dict : Dictionary) -> void:
	var entry : Dictionary = {}
	var entry_id : Variant = all_fields.slice(0, -1)[0]
	entry_id = parse_cell(entry_id)
	
	var i : int = 0
	for field in all_fields:
		var index : String = headers[i]
		entry[index] = parse_cell(field)
		i += 1

	if !stored_csv_dict.has(entry_id):
		stored_csv_dict[entry_id] = {}
	stored_csv_dict[entry_id] = entry
	
static func parse_cell(cell_text : String) -> Variant:
	cell_text = cell_text.replace('\r', '').trim_suffix(" ")
	return int(cell_text) if cell_text.is_valid_int() else cell_text
