class_name ChargeUpEffect
extends Effect

var amount := 0 

func _init(amount_in : int, sound_in : AudioStream, originator_in : Node) -> void:
	amount = amount_in
	sound = sound_in
	originator = originator_in

func execute(targets : Array[Node]) -> void:
	for target in targets:
		if not target is Enemy and not target is Player:
			continue
		target.add_status(Charge.new(amount))
	SfxPlayer.play(sound)
	
func pick_icon_for_intent() -> Texture:
	var charge_stacks : int = originator.stats.get_status_count(Charge)
	var intent_icon : Texture = preload("res://art/charge_up_0_3.png")
	if charge_stacks >= 0:
		intent_icon = preload("res://art/charge_up_1_3.png")
	if charge_stacks >= 1:
		intent_icon = preload("res://art/charge_up_2_3.png")
	if charge_stacks >= 2:
		intent_icon = preload("res://art/charge_up_3_3.png")
	
	return intent_icon

func generate_intent() -> Intent:
	var intent : Intent = Intent.new()
	intent.icon = pick_icon_for_intent()
	return intent
