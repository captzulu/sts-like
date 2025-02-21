class_name SoundBar 
extends VBoxContainer

@export var bus_name : String

func _ready() -> void:
	%SoundBar.value = Globals.CONFIG.get_value('audio', bus_name, 0.75)

func _on_sound_bar_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Globals.CONFIG.set_value("audio", bus_name, %SoundBar.value)
		Globals.CONFIG.save(Globals.CONFIG_PATH)
		set_volume()

func set_volume():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear_to_db(%SoundBar.value))
