class_name CardPileDisplay
extends Panel

@onready var card_container : FlowContainer = %CardsContainer
@onready var title_label : Label = %TitleLabel
@onready var card_ui : PackedScene = preload("res://scenes/card_ui/card_as_reward.tscn")

func _ready() -> void:
	%CloseButton.pressed.connect(close)

func open(card_pile : CardPile, title : String) -> void:
	title_label.text = title
	remove_cards_from_ui()
	add_cards_to_ui(card_pile)
	self.show()

func add_cards_to_ui(card_pile : CardPile) -> void:
	for card in card_pile.cards:
		var new_card_ui : CardAsReward = card_ui.instantiate()
		new_card_ui.card = card
		card_container.add_child(new_card_ui)

func remove_cards_from_ui() -> void:
	for card_ui in card_container.get_children():
		card_container.remove_child(card_ui)
		card_ui.queue_free()

func close() -> void:
	title_label.text = ""
	remove_cards_from_ui()
	self.hide()
