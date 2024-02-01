class_name StatusUi
extends HBoxContainer

@onready var stacks : Label = $Stacks
@onready var icon : TextureRect = $Icon

func update(new_stacks : int) -> void:
	stacks.text = str(new_stacks)

func init(status : Status) -> void:
	icon.texture = status.icon
	stacks.text = str(status.stacks)
	stacks.visible = status.stacks > 1
	show()
