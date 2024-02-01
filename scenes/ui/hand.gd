class_name Hand
extends HBoxContainer

@export var player : Player

@onready var card_ui := preload("res://scenes/card_ui/card_ui.tscn")
	
func add_card(card : Card) -> void:
	var new_card_ui : CardUi = card_ui.instantiate() as CardUi
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.player = player
	
func discard_card(card : CardUi) -> void:
	card.queue_free()

func disable_hand() -> void:
	for card in get_children():
		card.disabled = true

func _on_card_ui_reparent_requested(child: CardUi) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index : int = clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred('disabled', false)
