class_name EnemySpawner
extends Node

var enemy_scene : PackedScene = preload("res://scenes/enemy/enemy.tscn")
var boss_enemy_scene : PackedScene = preload("res://scenes/enemy/boss_enemy.tscn")
var mobs_directory : String = "res://enemies/mobs"
var boss_directory : String = "res://enemies/bosses"
var enemies : Dictionary = {}
var wave_index : int = 0
var wave_max : int

@onready var enemy_handler : EnemyHandler = %EnemyHandler

func _ready() -> void:
	load_mobs_to_dict()
	load_bosses_to_dict()
	wave_max = DataModule.data[Globals.current_location.identifier].size()
	#wave_max = 2

func spawn_wave() -> void:
	var spawn_nodes : Array[Node] = get_children()
	var enemy_node : Enemy
	wave_index += 1
	var i : int = 0
	for enemy in get_wave_enemies():
		
		enemy_node = (boss_enemy_scene if enemy.is_boss else enemy_scene).instantiate() as Enemy
		enemy_node.stats = enemy
		enemy_handler.add_child(enemy_node)
		enemy_node.add_to_group("enemies")
		enemy_node.position = spawn_nodes[i].position
		i += 1
	
	Events.wave_spawned.emit(wave_index)

func get_wave_enemies() -> Array[EnemyStats]:
	var wave_enemies : Array[EnemyStats] = []
	var wave_data : Dictionary = DataModule.data[Globals.current_location.identifier][wave_index - 1]
	for field : String in wave_data:
		var val : String = str(wave_data[field])
		if val != "id" and val.length() > 1 and val in enemies.keys():
			wave_enemies.append(enemies[val])
	return wave_enemies
	
func is_on_last_wave() -> bool:
	return wave_index == wave_max
	
func load_mobs_to_dict() -> void:
	enemies.merge(DataModule.FILE_MANAGER.load_directory_resources_to_dict(mobs_directory))

func load_bosses_to_dict() -> void:
	enemies.merge(DataModule.FILE_MANAGER.load_directory_resources_to_dict(boss_directory))
