class_name CompatLogUi
extends PanelContainer

const DEFAULT_STYLEBOX := preload("res://scenes/ui/combat_log/combat_log.tres")
const HOVER_STYLEBOX := preload("res://scenes/ui/combat_log/combat_log_hover.tres")

func _ready() -> void:
	Events.combat_log_updated.connect(on_log_updated)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	
func on_log_updated(line_added : String) -> void:
	%CombatLogText.text += "[p]" + line_added + "[/p]"

func on_mouse_entered() -> void:
	change_style_box(HOVER_STYLEBOX)

func on_mouse_exited() -> void:
	change_style_box(DEFAULT_STYLEBOX)

func change_style_box(_style_box: Resource) -> void:
	set("theme_override_styles/panel", _style_box)
