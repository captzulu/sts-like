class_name Player
extends Node2D

const WHITE_SPRITE_MATERIAL := preload("res://art/original_art/white_sprite_material.tres")

@export var stats : CharacterStats : set = set_character_stats

@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var stats_ui : StatsUi = $StatsUi as StatsUi
@onready var overhead_floating_text : Label = %OverheadFloatingText as FloatingTextUi
@onready var statuses_bar : StatusesBar = $StatusesBar as StatusesBar

func _ready() -> void:
	Events.enemy_death_exact_hp.connect(_on_enemy_death_exact_hp)
	Events.enemy_death_before_turn.connect(_on_enemy_death_first_turn)

func set_character_stats(value : CharacterStats) -> void:
	stats = value as CharacterStats
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_player()
	
func update_player() -> void:
	if not stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
		
	sprite_2d.texture = stats.art
	update_stats()
	
func update_stats() -> void:
	stats_ui.update_stats(stats)
	
func take_damage(damage : int, ignore_block : bool = false) -> void:
	if stats.health <= 0:
		return
	
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	
	var tween : Tween = create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage, ignore_block))
	tween.tween_interval(0.17)
	
	tween.finished.connect(
		func() -> void:
			sprite_2d.material = null
			if stats.health <= 0:
				Events.player_died.emit()
				queue_free()
	)
	
func heal(amount : int) -> bool:
	if stats.health + amount > stats.max_health:
		amount -= (stats.health + amount - stats.max_health)
		
	if amount <= 0:
		return false

	stats.heal(amount)
	return true

func heal_from_combos(combo_number : int) -> void:
	var healing_amount : int = combo_number + 1
	if heal(healing_amount):
		var floating_text : String = "Kill Combo %s\n! + %s HP" % [combo_number, healing_amount]
		overhead_floating_text.create_label(floating_text)

func _on_enemy_death_exact_hp(_enemy : Enemy) -> void:
	var amount : int = 2
	if heal(amount):
		var floating_text : String = "Exact Kill!\n + " + str(amount) + " HP"
		overhead_floating_text.create_label(floating_text)

func _on_enemy_death_first_turn(_enemy : Enemy) -> void:
	var amount : int = 2
	if heal(amount):
		var floating_text : String = "Before They Can Act!\n + " + str(amount) + " HP"
		overhead_floating_text.create_label(floating_text)
		
func add_status(status : Status) -> void:
	stats.add_status(status)
	statuses_bar.refresh_bar(stats.statuses_dict)
		
func get_spikes() -> int:
	if not stats.statuses_dict.has(Spike.get_identifier()):
		return 0
	else:
		return stats.statuses_dict[Spike.identifier].stacks
