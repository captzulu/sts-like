class_name CharacterStats
extends Stats

@export var starting_deck : CardPile
@export var cards_per_turn : int
@export var max_mana : int

var mana : int : set = set_mana
var deck : CardPile
var discard : CardPile
var draw_pile : CardPile

func set_mana(value : int) -> void:
	mana = value
	stats_changed.emit()

func reset_mana() -> void:
	self.mana = max_mana
	
func take_damage(damage : int, ignore_block : bool = false) -> void:
	var initial_health : int = health 
	super.take_damage(damage, ignore_block)
	
	if initial_health > health:
		Events.player_hit.emit()

func heal(amount : int) -> void:
	if amount <= 0:
		return
	health += amount

func can_play_card(card : Card) -> bool:
	return mana >= card.cost
	
func create_instance() -> Resource:
	var instance : CharacterStats = self.duplicate() as CharacterStats
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = self.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
	
