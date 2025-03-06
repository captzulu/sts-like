class_name CardUi
extends Control

const BASE_STYLEBOX := preload("res://scenes/card_ui/card_base_style_box.tres")
const HOVER_STYLEBOX := preload("res://scenes/card_ui/card_hover_style_box.tres")

@export var card: Card : set = _set_card

@onready var panel: Panel = $Panel
@onready var cost: Label = %Cost
@onready var icon: TextureRect = %Icon

var effects : Dictionary
var text_tooltip : String = ""
	
func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
		
	card = value
	self.effects = card.effects.duplicate(true)
	cost.text = str(card.cost)
	icon.texture = card.icon

func compute_tooltip() -> void:
	pass

func show_tooltip() -> void:
	change_style_box(HOVER_STYLEBOX)
	compute_tooltip()
	Events.card_tooltip_requested.emit(card.icon, text_tooltip)

func hide_tooltip() -> void:
	change_style_box(BASE_STYLEBOX)
	Events.hide_tooltip_requested.emit()

func change_style_box(_style_box: Resource) -> void:
	panel.set("theme_override_styles/panel", _style_box)
