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

func show_tooltip():
	if ! self.selected:
		change_style_box(HOVER_STYLEBOX)
	compute_tooltip()
	Events.card_tooltip_requested.emit(card.icon, text_tooltip)

func hide_tooltip():
	if ! self.selected:
		change_style_box(BASE_STYLEBOX)
	Events.hide_tooltip_requested.emit()

func select():
	self.selected = true
	change_style_box(SELECTED_STYLEBOX)

func unselect():
	self.selected = false
	change_style_box(BASE_STYLEBOX)
