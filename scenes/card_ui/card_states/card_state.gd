class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED}

signal transition_requested(from: CardState, to: State)

@export var state: State

var card_ui: CardUi

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func on_input(_event: InputEvent) -> void:
	pass

func on_gui_input(_event: InputEvent) -> void:
	pass
	
func on_mouse_entered() -> void:
	pass

func on_mouse_exited() -> void:
	pass
	
func _change_style_box(_style_box: Resource) -> void:
	card_ui.panel.set("theme_override_styles/panel", _style_box)
