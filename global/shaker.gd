extends Node

func shake(thing : Node2D, strength : float, duration : float = 0.2) -> void:
	if not thing:
		return
		
	var orig_pos : Vector2 = thing.position
	var shake_count : int = 10
	var tween : Tween = create_tween()
	
	for i in shake_count:
		var shake_offset : Vector2 = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		var target : Vector2 = orig_pos + strength * shake_offset
		if i % 2 == 0:
			target = orig_pos
		tween.tween_property(thing, "position", target, duration / float(shake_count))
		strength *= 0.75

	tween.finished.connect(
		func return_to_postion() -> void: 
			if not thing:
				return
			thing.position = orig_pos
			)
