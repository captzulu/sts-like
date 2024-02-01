class_name EnemyHandler
extends Node2D

var skip_next_turn : bool = false
var enemy_count : int = 0

func _ready() -> void:
	Events.enemy_action_completed.connect(_on_enemy_action_completed)
	Events.enemy_death.connect(_on_enemy_death)
	child_entered_tree.connect(_on_child_entered_tree)

func reset_enemy_actions() -> void:
	var enemy : Enemy
	for child in get_children():
		enemy = child as Enemy
		enemy.current_action = null
		enemy.update_action()
		
func start_turn() -> void:
	if get_child_count() == 0:
		return
	
	var first_enemy : Enemy = get_child(0) as Enemy
	first_enemy.do_turn()

func _on_enemy_action_completed(enemy : Enemy) -> void:
	if enemy.get_index() == get_child_count() - 1:
		Events.enemy_turn_ended.emit()
		return
		
	var next_enemy : Enemy = get_child(enemy.get_index() + 1) as Enemy
	next_enemy.do_turn()
	
func no_more_enemy() -> bool:
	return enemy_count == 0
	
func _on_enemy_death(_enemy : Enemy) -> void:
	if enemy_count > 0:
		enemy_count -= 1

func _on_child_entered_tree(_node: Node) -> void:
	enemy_count += 1
