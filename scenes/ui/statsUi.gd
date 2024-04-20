class_name StatsUi
extends HBoxContainer

@onready var block : HBoxContainer = $Block
@onready var block_label : Label = %BlockLabel
@onready var health : HBoxContainer = $Health
@onready var health_label : Label = %HealthLabel
var char_stats : Stats
const tooltip_y_offset : int = 10

func update_stats(stats: Stats) -> void:
	char_stats = stats
	block_label.text = str(char_stats.block)
	health_label.text = str(char_stats.health)
	
	block.visible = char_stats.block > 0
	health.visible = char_stats.health > 0
