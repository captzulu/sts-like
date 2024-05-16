class_name BattleUi
extends CanvasLayer

@export var char_stats : CharacterStats : set = _set_char_stats

@onready var hand : Hand = $Hand as Hand
@onready var mana_ui : ManaUi = $ManaUi as ManaUi
@onready var wave_ui : WaveUi = $WaveUi as WaveUi
@onready var end_turn_button : Button = %EndTurnButton
@onready var draw_pile_display : CardPileDisplay = %DrawPileDisplay
@onready var see_draw_pile : Button = %SeeDrawPileButton

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_draw)
	Events.wave_spawned.connect(_on_wave_spawned)
	end_turn_button.pressed.connect(_on_end_turn_button_pressed)
	see_draw_pile.pressed.connect(draw_pile_display.show)
	Events.card_played.connect(_on_card_played)
	Events.card_play_animation_finished.connect(_on_card_animation_finished)

func _set_char_stats(value : CharacterStats) -> void:
	char_stats = value
	mana_ui.char_stats = char_stats
	draw_pile_display.card_pile = char_stats.draw_pile
	
func set_wave_max(max_value : int) -> void:
	wave_ui.wave_progress_bar.max_value = max_value

func _on_player_hand_draw() -> void:
	draw_pile_display.card_pile = char_stats.draw_pile
	end_turn_button.disabled = false

func _on_end_turn_button_pressed() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()
	
func _on_wave_spawned(wave_number : int) -> void:
	wave_ui.increment_wave_progress(wave_number)
	
func _on_card_played(_card: Card) -> void:
	end_turn_button.disabled = true

func _on_card_animation_finished(_card: Card) -> void:
	end_turn_button.disabled = false
