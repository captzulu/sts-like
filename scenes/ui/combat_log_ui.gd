class_name CompatLogUi
extends RichTextLabel

func _ready() -> void:
	Events.combat_log_updated.connect(on_log_updated)
	
func on_log_updated(line_added : String) -> void:
	if text != "":
		text += "[p] [/p]"
	text += "[p]" + line_added + "[/p]" 
