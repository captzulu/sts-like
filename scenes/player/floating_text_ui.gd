class_name FloatingTextUi
extends Label

var active : bool = false
var queue : Array[FloatingTextUi]

func create_label(text_label : String) -> void:
	var new_floating_text : Label = duplicate()
	new_floating_text.text = text_label
	queue.append(new_floating_text)
	
func _process(_delta: float) -> void:
	if queue.is_empty() or active:
		return

	active = true
	var floating_text : FloatingTextUi = queue.pop_front()
	get_parent().add_child(floating_text)
	floating_text.show()
	var tween : Tween = create_tween().set_parallel()
	var start : Vector2 = floating_text.global_position
	var end : Vector2 = Vector2(start.x, start.y - 20)
	
	tween.tween_property(floating_text, "global_position", end, 2)
	tween.tween_property(floating_text, "modulate", Color.TRANSPARENT, 2)
	tween.finished.connect(
		func() -> void: floating_text.queue_free()
	)
	await get_tree().create_timer(0.75).timeout
	active = false
