class_name Enemy
extends Area2D

const ARROW_OFFSET : int = 5
const WHITE_SPRITE_MATERIAL := preload("res://art/original_art/white_sprite_material.tres")

@export var stats : EnemyStats : set = set_enemy_stats

@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var arrow : Sprite2D = $Arrow
@onready var stats_ui : StatsUi = $StatsUi as StatsUi
@onready var intent_ui : IntentUi = $IntentUi as IntentUi
@onready var statuses_bar : StatusesBar = $StatusesBar as StatusesBar

var enemy_handler : EnemyHandler
var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction : set = set_current_action
var last_action: EnemyAction
var turn_alive : int = 0
var difficulty : int

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	
func set_current_action(value : EnemyAction) -> void:
	current_action = value

func set_enemy_stats(value: EnemyStats) -> void:
	difficulty = Globals.current_location.unlocked_level - 1
	stats = value.create_instance(difficulty, 0.10) as EnemyStats
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		stats.stats_changed.connect(update_action)
	
	update_enemy()

func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()
		
	var new_action_picker : EnemyActionPicker = stats.ai.instantiate()
	new_action_picker.enemy = self
	new_action_picker.difficulty = difficulty
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	
func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
		
	sprite_2d.texture = stats.art
	sprite_2d.scale = stats.scale
	arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x / 2 + ARROW_OFFSET)
	setup_ai()
	update_stats()

func do_turn() -> void:
	stats.block = 0
	
	if not current_action or is_queued_for_deletion():
		return
	last_action = current_action
	current_action.perform_action()
	turn_alive += 1
	
func update_stats() -> void:
	stats_ui.update_stats(stats)

func update_action() -> void:
	if not enemy_action_picker:
		return
	
	if not current_action:
		current_action = enemy_action_picker.get_action()
		intent_ui.update_intent(current_action.generate_intents())
		return
	
	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action
	
	intent_ui.update_intent(current_action.generate_intents())
	
func take_damage(damage : int, ignore_block : bool = false) -> void:
	if stats.health <= 0:
		return
		
	var initial_health : int = stats.health
	var initial_block : int = stats.block
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	
	var tween : Tween = create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage, ignore_block))
	tween.tween_interval(0.17)
	
	tween.finished.connect(
		func() -> void: 
			sprite_2d.material = null
			if stats.health <= 0:
				death(initial_health, initial_block, damage)
	)

func heal(amount : int) -> bool:
	if stats.health + amount > stats.max_health:
		amount -= (stats.health + amount - stats.max_health)
		
	if amount <= 0:
		return false

	stats.heal(amount)
	return true

func add_status(status : Status) -> void:
	stats.add_status(status)
	statuses_bar.refresh_bar(stats.statuses_dict)

func death(initial_health : int, initial_block : int, damage_received : int) -> void:
	Events.enemy_death.emit(self)
	var enemy_effective_hp : int = initial_health + initial_block
	if enemy_effective_hp == damage_received:
		Events.enemy_death_exact_hp.emit(self)
	elif enemy_effective_hp < damage_received:
		Events.enemy_death_overkill.emit(damage_received - enemy_effective_hp)
	if turn_alive == 0:
		Events.enemy_death_before_turn.emit(self)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is not Player:
		arrow.show()

func _on_area_exited(_area: Area2D) -> void:
	arrow.hide()
	
func _on_mouse_entered() -> void:
	Events.status_tooltip_requested.emit(stats.statuses_dict)

func _on_mouse_exited() -> void:
	Events.hide_tooltip_requested.emit()

func get_spikes() -> int:
	return get_status(Spike)

func get_status(status) -> int:
	return stats.get_status_stacks(status)
