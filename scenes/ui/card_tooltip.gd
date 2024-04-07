class_name Tooltip
extends PanelContainer

@export var fade_seconds : float = 0.2

@onready var tooltip_icon : TextureRect = %TooltipIcon
@onready var tooltip_text_label : RichTextLabel = %TooltipText

var tween: Tween
var is_visible: bool = false


func _ready() -> void:
	Events.card_tooltip_requested.connect(show_card_tooltip)
	Events.status_tooltip_requested.connect(show_status_tooltip)
	Events.hide_tooltip_requested.connect(hide_tooltip)
	modulate = Color.TRANSPARENT
	hide()
	
func show_card_tooltip(icon : Texture, text : String) -> void:
	is_visible = true
	if tween:
		tween.kill()

	global_position = Vector2(210, 10)
	size = Vector2(110, 34)
	tooltip_icon.texture = icon
	tooltip_text_label.text = text 
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds)
	
func show_status_tooltip(icon : Texture, text : String, position : Vector2) -> void:
	is_visible = true
	if tween:
		tween.kill()

	global_position = position
	size = Vector2(54, 16)
	tooltip_icon.texture = icon
	tooltip_text_label.text = text 
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds)

func hide_tooltip() -> void:
	is_visible = false
	if tween:
		tween.kill()
		
	get_tree().create_timer(fade_seconds, false).timeout.connect(hide_animation)

func hide_animation() -> void:
	if not is_visible:
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_seconds)
		tween.tween_callback(hide)
