class_name StoneskinEffect
extends Effect

var amount := 0 

func _init(amount_in : int, sound_in : AudioStream, originator_in : Node = null) -> void:
	amount = amount_in
	sound = sound_in
	originator = originator_in

func execute(targets : Array[Node]) -> void:
	for target in targets:
		if not target is Enemy and not target is Player:
			continue
		var stoneskin : Stoneskin = Stoneskin.new(amount)
		stoneskin.add_to(target)
	SfxPlayer.play(sound)

func pick_icon_for_intent() -> Texture:
	var intent_icon : Texture = preload("res://art/stoneskin.png")
	return intent_icon

func generate_intent() -> Intent:
	var intent : Intent = Intent.new()
	intent.icon = pick_icon_for_intent()
	intent.number = "[color=\"00c41b\"]%s[/color]" % str(amount)
	return intent
