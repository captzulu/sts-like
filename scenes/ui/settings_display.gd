class_name SettingsDiplay
extends CanvasLayer

@onready var close_button : Button = %CloseButton

func _ready() -> void:
	close_button.pressed.connect(self.hide)
