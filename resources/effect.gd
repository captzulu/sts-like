class_name Effect
extends RefCounted

var sound : AudioStream
var originator : Node
var difficulty : int

func execute(_targets: Array[Node]) -> void:
	pass

func pick_icon_for_intent() -> Texture:
	return null
	
func generate_intent() -> Intent:
	return null
