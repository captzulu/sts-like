class_name CompatLogUi
extends PanelContainer

const DEFAULT_STYLEBOX := preload("res://scenes/ui/combat_log/combat_log.tres")
const HOVER_STYLEBOX := preload("res://scenes/ui/combat_log/combat_log_hover.tres")
const FULL_HEIGHT : int = 120
const COLLAPSED_HEIGHT : int = 40

@onready var expand_button = %ExpandButton
@onready var is_collapsed : bool = %ExpandButton.is_pressed()

func _ready() -> void:
	Events.combat_log_updated.connect(on_log_updated)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	%ExpandButton.pressed.connect(on_expand_click)
	resize_window()
	
func on_log_updated(line_added : String) -> void:
	%CombatLogText.text += "[p]" + line_added + "[/p]"

func on_mouse_entered() -> void:
	change_style_box(HOVER_STYLEBOX)

func on_mouse_exited() -> void:
	change_style_box(DEFAULT_STYLEBOX)

func change_style_box(_style_box: Resource) -> void:
	set("theme_override_styles/panel", _style_box)

func on_expand_click() -> void:
	is_collapsed = ! is_collapsed
	resize_window()

func resize_window() -> void:
	print("is_collapsed : " + str(is_collapsed))
	if is_collapsed:
		self.size.y = FULL_HEIGHT
	else:
		self.size.y = COLLAPSED_HEIGHT
	print("size y : " + str(self.size.y))
	
