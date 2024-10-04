class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL : float = 0.25
const HAND_DISCARD_INTERVAL : float = 0.25

@export var hand : Hand

var player : Player 
var hand_being_discarded : bool = false
var enemy_killed_this_turn : int = 0

func _ready() -> void:
	Events.player_turn_ended.connect(end_turn)
	Events.card_played.connect(_on_card_played)

func start_battle() -> void:
	player.stats.draw_pile = player.stats.starting_deck.duplicate(true)
	player.stats.draw_pile.shuffle()
	player.stats.discard = CardPile.new()
	start_turn()
	
func start_turn() -> void:
	if enemy_killed_this_turn > 1:
		player.heal_from_combos(enemy_killed_this_turn)
	enemy_killed_this_turn = 0
	Events.player_turn_started.emit()
	player.stats.block = 0
	player.stats.reset_mana()
	draw_cards(player.stats.cards_per_turn)
	
func end_turn() -> void:
	hand.disable_hand()
	discard_cards()

func draw_card() -> void:
	reshuffle_deck_from_discard()
	var card : Card = player.stats.draw_pile.draw_card()
	hand.add_card(card)
	reshuffle_deck_from_discard()
	
func draw_cards(amount : int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(
		func() -> void: Events.player_hand_drawn.emit()
	)
	
func discard_cards() -> void:
	hand_being_discarded = true
	var cards : Array = hand.get_children()
	if cards.size() == 0:
		end_discarding()
		return

	var tween := create_tween()
	for card_ui in cards:
		tween.tween_callback(player.stats.discard.add_card.bind(card_ui.card))
		tween.tween_callback(hand.discard_card.bind(card_ui))
		tween.tween_interval(HAND_DISCARD_INTERVAL)
	
	tween.finished.connect(end_discarding)

func end_discarding() -> void: 
	hand_being_discarded = false
	Events.player_hand_discarded.emit()

func reshuffle_deck_from_discard() -> void:
	if not player.stats.draw_pile.empty():
		return
	
	while not player.stats.discard.empty():
		player.stats.draw_pile.add_card(player.stats.discard.draw_card())
	
	player.stats.draw_pile.shuffle()
	
func _on_card_played(card : Card) -> void:
	player.stats.discard.add_card(card)
