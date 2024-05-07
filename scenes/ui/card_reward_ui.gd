extends CanvasLayer

@onready var main_menu : PackedScene = preload("res://scenes/ui/main_menu.tscn")
@onready var card_ui : PackedScene = preload("res://scenes/card_ui/card_as_reward.tscn")
@onready var card_rewards_container : HBoxContainer = %CardRewards

func _ready():
	%ConfirmButton.pressed.connect(get_reward)
	%SkipButton.pressed.connect(back_to_main_menu)
	setup_rewards()
	Events.select_card_reward.connect(select_reward)
	
func setup_rewards() -> void:
	var local_reward_cards : Dictionary = Globals.reward_cards.duplicate()
	local_reward_cards[local_reward_cards.keys().pick_random()]
	for i in range(3):
		var random_key = local_reward_cards.keys().pick_random()
		var new_card : Card = local_reward_cards[random_key]
		var new_card_ui : CardAsReward = card_ui.instantiate()
		new_card_ui.card = new_card
		card_rewards_container.add_child(new_card_ui)
		local_reward_cards.erase(random_key)

func select_reward(card_selected : CardAsReward) -> void:
	for card in %CardRewards.get_children():
		card.unselect()
	
	card_selected.select()
	
func get_reward() -> void:
	var card_reward = %CardRewards.get_children().filter(func(card): return card.selected == true)
	if card_reward.size() == 1:
		Globals.char_stats.starting_deck.add_card(card_reward[0].card)
	back_to_main_menu()

func back_to_main_menu() -> void:
	for card in %CardRewards.get_children():
		card.queue_free()
	Globals.current_location.completed = true
	var map_index = Globals.MAP_ORDER.find(Globals.current_location)
	Globals.MAP_ORDER[map_index + 1].unlocked = true
	Globals.current_location = null

	get_tree().change_scene_to_packed(main_menu)
