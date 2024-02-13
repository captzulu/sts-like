extends Node

signal remove_status(status_id : String)

#region Card-related events
signal card_drag_started(card_ui: CardUi) 
signal card_drag_ended(card_ui: CardUi)
signal card_aim_started(card_ui: CardUi)
signal card_aim_ended(card_ui: CardUi)
signal card_played(card: Card)
signal card_play_animation_finished(card: Card)
signal card_tooltip_requested(card: Card)
signal hide_tooltip_requested
#endregion

#region Player-related events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_started
signal player_turn_ended
signal player_hit
signal player_died
#endregion

#region Enemy-related events
signal enemy_action_completed(enemy : Enemy)
signal enemy_death(enemy : Enemy)
signal enemy_death_exact_hp(enemy : Enemy)
signal enemy_turn_ended
signal enemy_death_before_turn(enemy : Enemy)
#endregion

#region Battle-related events
signal battle_over_screen_requested(text : String, type : BattleOverPanel.Type)
signal wave_spawned(wave_number : int)
#endregion

#region Effect-related events
signal damage_effect(originator : Node, target : Node)
#endregion
