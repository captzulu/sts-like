class_name StatsUi
extends HBoxContainer

@onready var block : HBoxContainer = $Block
@onready var block_label : Label = %BlockLabel
@onready var health : HBoxContainer = $Health
@onready var health_label : Label = %HealthLabel
var char_stats : Stats

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)

func update_stats(stats: Stats) -> void:
	char_stats = stats
	block_label.text = str(char_stats.block)
	health_label.text = str(char_stats.health)
	
	block.visible = char_stats.block > 0
	health.visible = char_stats.health > 0
	
func _on_mouse_entered() -> void:
	#char_stats.statuses_dict
	#for each statuses, add an icon and text to an array
	Events.status_tooltip_requested.emit()
