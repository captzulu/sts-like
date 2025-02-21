class_name BattleOverPanel
extends Panel

enum Type{WIN, LOSE}
var card_reward : PackedScene = preload("res://scenes/ui/card_reward_ui.tscn")
var main_menu : PackedScene = preload("res://scenes/ui/main_menu/main_menu.tscn")
var saver_loaded : SaverLoader
var lose_sound : AudioStream = preload("res://art/musicAndSounds/Failure.wav")
var lose_music : AudioStream = preload("res://art/musicAndSounds/Campfire.wav")
var win_sound : AudioStream = preload("res://art/musicAndSounds/Success2A.wav")
var win_music : AudioStream = preload("res://art/musicAndSounds/ARoguesEndeavor.wav")

@onready var label : Label = %Label
@onready var continue_button : Button = %ContinueButton
@onready var restart_button : Button = %RestartButton
@onready var exit_button : Button = %ExitButton

func _ready() -> void:
	continue_button.pressed.connect(_on_continue_button_pressed)
	restart_button.pressed.connect(_restart_button_pressed)
	exit_button.pressed.connect(_exit_button_pressed)
	Events.battle_over_screen_requested.connect(show_screen)
	
func show_screen(text : String, type: Type) -> void:
	label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	exit_button.visible = type == Type.LOSE

	if type == Type.LOSE:
		delete_save()
	
	play_music(type)
	show()
	get_tree().paused = true

func play_music(type) -> void:
	MusicPlayer.stop()
	if SfxPlayer.sound_finished.is_connected(MusicPlayer.play):
		SfxPlayer.sound_finished.disconnect(MusicPlayer.play)
	if type == Type.LOSE:
		SfxPlayer.play(lose_sound, true)
		await get_tree().create_timer(1, true).timeout
		MusicPlayer.play(lose_music, true, true)
	else:
		SfxPlayer.play(win_sound, true)
		await get_tree().create_timer(1, true).timeout
		MusicPlayer.play(win_music, true, true)

func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(card_reward)
	
func _restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)
	
func _exit_button_pressed() -> void:
	get_tree().quit()
	
func delete_save() -> void:
	if ! saver_loaded:
		saver_loaded = SaverLoader.new()
	saver_loaded.delete_save()
	
	
