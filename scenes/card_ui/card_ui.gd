class_name CardUi
extends Control

signal reparent_requested(requesting_card: CardUi)

const BASE_STYLEBOX := preload("res://scenes/card_ui/card_base_style_box.tres")
const DRAG_STYLEBOX := preload("res://scenes/card_ui/card_dragging_style_box.tres")
const HOVER_STYLEBOX := preload("res://scenes/card_ui/card_hover_style_box.tres")

@export var card: Card : set = _set_card
@export var player: Player : set = _set_player

@onready var panel: Panel = $Panel
@onready var cost: Label = $Cost
@onready var icon: TextureRect = $Icon
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets : Array[Node] = []

var original_index : int = 0
var parent : Control
var tween : Tween
var playable : bool = true : set = _set_playable
var disabled : bool = false
var effects : Dictionary
var text_tooltip : String = ""

func _ready() -> void:
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.card_aim_ended.connect(_on_card_drag_or_aiming_ended)
	Events.card_drag_ended.connect(_on_card_drag_or_aiming_ended)
	card_state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)
	
func play() -> void:
	if not card:
		return
		
	card.play(targets, player)
	queue_free()
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
	
func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
		
	card = value
	self.effects = card.effects.duplicate(true)
	cost.text = str(card.cost)
	icon.texture = card.icon

func _set_playable(value: bool) -> void:
	playable = value
	if not playable:
		cost.add_theme_color_override("font_color", Color.RED)
		icon.modulate = Color(1, 1, 1, 0.5)
	else:
		cost.remove_theme_color_override("font_color")
		icon.modulate = Color(1, 1, 1, 1)

func _set_player(value : Player) -> void:
	player = value as Player
	player.stats.stats_changed.connect(_on_char_stats_changed)

func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
	
func _on_card_drag_or_aiming_started(used_card: CardUi) -> void:
	if used_card == self:
		return
	disabled = true

func _on_card_drag_or_aiming_ended(_used_card: CardUi) -> void:
	disabled = false
	self.playable = player.stats.can_play_card(card)
	
func _on_char_stats_changed() -> void:
	self.playable = player.stats.can_play_card(card)
	
func compute_tooltip():
	text_tooltip = card.tooltip_text_template.format(self.effects)
