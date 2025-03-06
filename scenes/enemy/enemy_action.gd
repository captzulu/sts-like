class_name EnemyAction
extends Node

enum Type {CONDITIONAL, CHANCE_BASED, ON_INIT}

@export var sound : AudioStream
@export var type : Type
@export var identifier : String = ""
@export_range(0.0, 10.0) var chance_weight : float = 0.0
@onready var accumulated_weight : float = 0.0

@export var effects : Array
var enemy : Enemy
var target : Node2D
var execution_number : int = 1
var execution_interval : float = 0.35
var difficulty : int

func is_performable() -> bool:
	return false
	
func perform_action() -> void:
	pass
	
func setup_effects() -> void:
	pass
	
func get_effect_value(effect) -> int:
	if typeof(effect) == TYPE_INT:
		return effect
	return effect[difficulty]

func generate_intents() -> Array[Intent]:
	if effects.size() <= 0:
		return []
	
	var intent : Intent
	var intents : Array[Intent] = []
	for effect in effects:
		intent = effect.generate_intent()
		if execution_number > 1:
			intent.number = "%sx%s" % [execution_number, intent.number]
		intents.append(intent)
	return intents
	
func calculate_health_percent(stats : Stats) -> int:
	return floor((stats.health / stats.max_health) * 100)
		
