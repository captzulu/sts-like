class_name LocationUi
extends Control

signal enter_location
var location : Location : set = set_location

func switch_location() -> void:
	if self.location.unlocked_level < 1:
		return
	Globals.current_location = self.location
	enter_location.emit()

func set_location(value : Location) -> void:
	location = value
	var location_button : Button = %LocationButton
	location_button.text = self.location.display_name
	location_button.pressed.connect(switch_location)
	location_button.disabled = self.location.unlocked_level == 0 or self.location.completed_level >= 3
	
	update_difficulty()

func update_difficulty() -> void:
	var difficulty_icons : Array = %DifficultyIconContainer.get_children()
	for icon : TextureRect in difficulty_icons:
		icon.show()

	var locked_icons : Array = difficulty_icons.slice(self.location.unlocked_level)
	for icon : TextureRect in locked_icons:
		icon.hide()

	var completed_icons : Array = difficulty_icons.slice(0, self.location.completed_level)
	for icon : TextureRect in completed_icons:
		icon.material = null
	
	if self.location.completed_level < 3:
		var matching_icon : TextureRect = difficulty_icons[self.location.unlocked_level - 1]
		matching_icon.material = preload("res://scenes/ui/main_menu/greyscale_shader_material.tres")
	
	if self.location.completed_level == 3:
		%CompletionOverlay.show()
