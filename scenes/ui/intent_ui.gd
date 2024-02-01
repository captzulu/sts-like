class_name IntentUi
extends HBoxContainer

func update_intent(intents : Array[Intent]) -> void:
	if intents.size() <= 0:
		hide()
		return

	var i : int = 0
	for intent_ui in get_children():
		if intents.size() - 1 < i:
			intent_ui.hide()
			return
		
		var icon : TextureRect = intent_ui.find_child("Icon")
		var number : RichTextLabel = intent_ui.find_child("Number")
			
		var intent : Intent = intents[i]
		icon.texture = intent.icon
		icon.visible = icon.texture != null
		number.text = str(intent.number)
		number.visible = intent.number.length() > 0
		intent_ui.show()
		i += 1
	
	show()
