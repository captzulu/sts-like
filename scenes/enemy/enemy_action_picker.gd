class_name EnemyActionPicker
extends Node


@onready var total_weight : float = 0.0
var actions : Array[EnemyAction]
var enemy : Enemy
var target : Node2D : set = _set_target

func _ready() -> void:
	for child in get_children():
		var enemy_action = child as EnemyAction
		enemy_action.enemy = enemy
		actions.append(enemy_action)
		enemy_action.setup_effects()
		
	target = get_tree().get_first_node_in_group("player")
	setup_chances()
	
func get_action() -> EnemyAction:
	var action : EnemyAction = get_first_conditional_action()
	if not action: 
		action = get_chance_based_action()
	return action

func get_first_conditional_action() -> EnemyAction:
	for action in actions:
		if action.type != EnemyAction.Type.CONDITIONAL:
			continue
		
		if action.is_performable():
			return action
	
	return null

func get_chance_based_action() -> EnemyAction:
	var roll : float = randf_range(0.0, total_weight)
	
	for action in actions:
		if action.type != EnemyAction.Type.CHANCE_BASED:
			continue
			
		if action.accumulated_weight > roll:
			return action
	
	return null

func setup_chances() -> void:
	for action in actions:
		if action.type != EnemyAction.Type.CHANCE_BASED:
			continue
		
		total_weight += action.chance_weight
		action.accumulated_weight = total_weight

func _set_target(value : Node2D) -> void:
	target = value
	
	for action in actions:
		action.target = target
