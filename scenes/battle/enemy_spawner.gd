class_name EnemySpawner
extends Node

var enemy_scene : PackedScene = preload("res://scenes/enemy/enemy.tscn")
var boss_enemy_scene : PackedScene = preload("res://scenes/enemy/boss_enemy.tscn")
var mobs_directory : String = "res://enemies/mobs"
var boss_directory : String = "res://enemies/bosses"
var enemies : Dictionary = {}
var wave_index : int = 0
var waves_data : Dictionary

@onready var enemy_handler : EnemyHandler = %EnemyHandler

func _ready() -> void:
	load_mobs_to_dict()
	load_bosses_to_dict()
	var test_limit = 0
	waves_data = Globals.current_location.getWavesData(test_limit)

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
	var wave_data : Array = waves_data[wave_index - 1]
	for enemy in wave_data:
		if enemy in enemies.keys():
			wave_enemies.append(enemies[enemy])
	return wave_enemies
	
func is_on_last_wave() -> bool:
	#return wave_index == 2
	return wave_index == waves_data.size()
	
func load_mobs_to_dict() -> void:
	enemies.merge(DataModule.load_directory_resources_to_dict(mobs_directory))

func load_bosses_to_dict() -> void:
	enemies.merge(DataModule.load_directory_resources_to_dict(boss_directory))
