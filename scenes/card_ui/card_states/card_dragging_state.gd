extends CardState

const DRAG_MINIMUM_THRESHOLD : float = 0.05
const MOUSE_Y_SNAPBACK_THRESHOLD := 330

var minimum_drag_time_elapsed : bool = false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	card_ui.reparent(ui_layer)
	
	card_ui.change_style_box(card_ui.DRAG_STYLEBOX)
	Events.card_drag_started.emit(card_ui)
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	await threshold_timer.timeout
	minimum_drag_time_elapsed = true

func exit() -> void:
	Events.card_drag_ended.emit(card_ui)

func on_input(event: InputEvent) -> void:
	var single_targeted : bool = card_ui.card.is_single_targeted()
	var mouse_motion : bool = event is InputEventMouseMotion
	var cancel : bool = event.is_action_pressed("right_mouse")
	var confirm : bool = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD
	
	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
		
	if cancel or mouse_at_bottom:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
