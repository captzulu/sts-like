class_name SkeletonSwarm
extends Status

var type : Type = Type.BUFF
const identifier = "Skeleton_Swarm"
const icon_path : String = "res://art/skeleton_swarm.png"

static func get_identifier() -> String:
	return identifier

func _init(amount : int) -> void:
	stacks = amount
	icon = preload(icon_path)

func generate_tooltip() -> String:
	return "Skeleton attacks for [color=\"" + Globals.TOOLTIP_DAMAGE_TEXT_COLOR + "\"]1[/color] more damage for each other skeleton."
