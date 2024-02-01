class_name Status
extends RefCounted

enum DecreaseOn{HIT, ATTACK, TURN_END, KILL, DEATH}
enum Type{BUFF, DEBUFF}

var stacks : int : set = update_ui
var is_on : Node
var ui_element : StatusUi
var icon : Texture

static func get_identifier() -> String:
	return ""

func generate_tooltip() -> String:
	return ""

func add_to(target : Node) -> void:
	if is_instance_of(target, Enemy) or is_instance_of(target, Player):
		is_on = target
		target.add_status(self)

func update_ui(value : int) -> void:
	stacks = value
	if not ui_element:
		return
	
	if stacks <= 0:
		ui_element.queue_free()
	else:
		ui_element.update(stacks)
