extends Node

const CONSTANTS = preload("res://modules/data_file_module/constants.gd")
const FILE_COMPILER = preload("res://modules/data_file_module/data_compiler.gd")
const FILE_MANAGER = preload("res://modules/data_file_module/data_file_manager.gd")

var data : Dictionary = {
	"spider_cavern" = {},
	"cyclop_halls" = {},
	"undead_lair" = {}
}

func _ready() -> void:
	FILE_COMPILER.compile_data_files()
	FILE_COMPILER.build_data_dict(data)
	#pass
