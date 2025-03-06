class_name CardAsReward
extends CardUi

const SELECTED_STYLEBOX := preload("res://scenes/card_ui/card_dragging_style_box.tres")

var selected : bool = false
	
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		Events.select_card_reward.emit(self)
		
func _on_mouse_entered() -> void:
	self.show_tooltip()
	
func _on_mouse_exited() -> void:
	self.hide_tooltip()

func show_tooltip() -> void:
	if ! self.selected:
		change_style_box(HOVER_STYLEBOX)
	self.compute_tooltip()
	Events.card_tooltip_requested.emit(card.icon, text_tooltip)

func compute_tooltip() -> void:
	text_tooltip = card.tooltip_text_template.format(self.effects)

func hide_tooltip() -> void:
	if ! self.selected:
		change_style_box(BASE_STYLEBOX)
	Events.hide_tooltip_requested.emit()

func select() -> void:
	self.selected = true
	change_style_box(SELECTED_STYLEBOX)

func unselect() -> void:
	self.selected = false
	change_style_box(BASE_STYLEBOX)
