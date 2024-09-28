class_name DamageEffect
extends Effect

var amount : int = 0
var damage : int = 0

func _init(amount_in : int, sound_in : AudioStream, originator_in : Node) -> void:
	if ! originator_in:
		return
	amount = amount_in
	sound = sound_in
	originator = originator_in
	calculate_damage()

func execute(targets : Array) -> void:
	for target in targets:
		if not target is Enemy and not target is Player:
			continue

		target.take_damage(self.damage)
		Events.damage_effect.emit(originator, target)
	SfxPlayer.play(sound)

func calculate_damage() -> void:
	var damage_multiplier : float = originator.stats.current_damage_modifier()
	self.damage = roundi(amount * damage_multiplier)

func pick_icon_for_intent() -> Texture:
	var intent_icon : Texture = preload("res://art/original_art/tile_0103.png")
	if amount >= 5:
		intent_icon = preload("res://art/original_art/tile_0104.png")
	if amount >= 10:
		intent_icon = preload("res://art/original_art/tile_0119.png")
	if amount >= 15:
		intent_icon = preload("res://art/original_art/tile_0117.png")
	if amount >= 20:
		intent_icon = preload("res://art/original_art/tile_0118.png")
	
	return intent_icon

func generate_intent() -> Intent:
	var intent : Intent = Intent.new()
	intent.icon = pick_icon_for_intent()
	calculate_damage()
	intent.number = "[color=\"ebc807\"]%s[/color]" % str(self.damage)
	return intent
