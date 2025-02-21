extends Node2D

@export var char_stats : CharacterStats
@export var music : AudioStream

@onready var battle_ui : BattleUi = $BattleUi as BattleUi
@onready var player_handler : PlayerHandler = $PlayerHandler as PlayerHandler
@onready var phase_handler : PhaseHandler = $PhaseHandler as PhaseHandler
@onready var enemy_handler : EnemyHandler = $EnemyHandler as EnemyHandler
@onready var enemy_spawner : EnemySpawner = $EnemySpawner as EnemySpawner
@onready var menu_button : Button = %MenuButton
@onready var battle_menu : CanvasLayer = $BattleMenu
@onready var player : Player = $Player as Player

func _ready() -> void:
	# Normally, we would do this on a 'Run' level so we keep our health,
	#  gold and deck between battles.
	var new_stats : CharacterStats = Globals.char_stats.create_instance()
	player.stats = new_stats
	player_handler.player = player
	battle_ui.char_stats = player.stats
	$BattleUi/WaveUi/WaveProgressBar.max_value = enemy_spawner.waves_data.size()
	
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	Events.enemy_death.connect(_on_enemy_death)
	
	Events.player_hand_discarded.connect(_on_player_hand_discarded)
	Events.player_died.connect(_on_player_died)
	Events.damage_effect.connect(_on_damage_effect_used)
	menu_button.pressed.connect(battle_menu.show)
	set_map()
	start_battle()
	
func start_battle() -> void:
	get_tree().paused = false
	MusicPlayer.play(music, true)
	spawn_wave()
	player_handler.start_battle()

func set_map() -> void:
	if self.get_child_count() > 0:
		for map in $Map.get_children():
			$Map.remove_child(map)
	$Map.add_child(Globals.current_location.tilemap.instantiate())

func spawn_wave() -> void:
	if phase_handler.current_phase == phase_handler.Phase.PLAY:
		await Events.player_turn_ended
	enemy_spawner.spawn_wave()
	enemy_handler.reset_enemy_actions()
	
func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()
		
func _on_player_died() -> void:
	Events.battle_over_screen_requested.emit("Game Over!", BattleOverPanel.Type.LOSE)

func _on_player_hand_discarded() -> void:
	if enemy_handler.skip_next_turn:
		enemy_handler.skip_next_turn = false
		player_handler.start_turn()
		return
	enemy_handler.start_turn()
	
func _on_enemy_death(enemy : Enemy) -> void:
	enemy_handler.enemy_death()
	player_handler.enemy_killed_this_turn += 1
	phase_handler.enemy_death(enemy)
	
	if enemy_handler.no_more_enemy() == false:
		return

	if enemy_spawner.is_on_last_wave():
		end_map()
	else:
		spawn_wave()
	
func _on_damage_effect_used(originator : Node, target : Node) -> void:
	if target.get_spikes() > 0: 
		originator.take_damage(target.get_spikes())
		
func end_map() -> void:
	Events.battle_over_screen_requested.emit("Victorious !", BattleOverPanel.Type.WIN)
