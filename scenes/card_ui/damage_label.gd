class_name DamageLabel
extends Node

@onready var damage_number_label: Label = %DamageNumber

func update_damage_number(new_damage_number : int) -> void:
	damage_number_label.text = str(new_damage_number)
