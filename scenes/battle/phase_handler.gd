class_name PhaseHandler
extends Node

enum Phase {DRAW, PLAY, DISCARD, ENEMY_TURN}

var current_phase : Phase = Phase.DRAW
@onready var enemy_handler : EnemyHandler = %EnemyHandler as EnemyHandler

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	Events.player_turn_ended.connect(_on_player_turn_ended)
	Events.player_hand_discarded.connect(_on_player_hand_discarded)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
func _on_player_hand_drawn() -> void:
	current_phase = Phase.PLAY

func _on_player_turn_ended() -> void:
	current_phase = Phase.DISCARD

func _on_player_hand_discarded() -> void:
	current_phase = Phase.ENEMY_TURN
	
func _on_enemy_turn_ended() -> void:
	current_phase = Phase.DRAW
	
func enemy_death(enemy : Enemy) -> void:
	if current_phase == Phase.ENEMY_TURN:
		Events.enemy_action_completed.emit(enemy)
		
	if enemy_handler.no_more_enemy():
		enemy_handler.skip_next_turn = true
		if current_phase in [Phase.ENEMY_TURN, Phase.DRAW]:
			enemy_handler.skip_next_turn = false
