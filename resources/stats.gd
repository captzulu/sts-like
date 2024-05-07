class_name Stats
extends Resource

signal stats_changed

@export var max_health : int = 1
@export var art : Texture

var health : int : set = set_health
var block : int : set = set_block
var statuses_dict : Dictionary = {}

func set_health(value : int) -> void:
	health = clampi(value, 0 , max_health)
	stats_changed.emit()
	
func set_block(value : int) -> void:
	block = clampi(value, 0 , 999)
	stats_changed.emit()

func add_status(status : Status) -> void:
	if statuses_dict.has(status.identifier):
		statuses_dict[status.identifier].stacks += status.stacks
	else:
		statuses_dict[status.identifier] = status
	stats_changed.emit()

func remove_status(identifier : String) -> void:
	if statuses_dict.has(identifier):
		statuses_dict.erase(identifier)
	stats_changed.emit()

func get_status_count(status) -> int:
	if statuses_dict.has(status.identifier):
		return statuses_dict[status.identifier].stacks
	else:
		return 0
	
func take_damage(damage : int, ignore_block : bool = false) -> void:
	if damage <= 0:
		return
	var initial_damage : int = damage
	if not ignore_block:
		damage = clampi(damage - block, 0, damage)
		self.block = clampi(block - initial_damage, 0, block)
	if get_status_count(Undying) > 0 and self.health - damage < 1:
		damage = clampi(damage, 0, self.health - 1)
		statuses_dict[Undying.identifier].decrease_stacks(1)
	if get_status_count(Enrage) > 0:
		statuses_dict[Enrage.identifier].is_being_hit()
	self.health -= damage

func heal(amount : int) -> void:
	self.health += amount

func create_instance() -> Resource:
	var instance : Stats = self.duplicate() as Stats
	instance.health = max_health
	instance.block = 0
	instance.statuses_dict = {}
	return instance

func current_damage_modifier() -> float:
	var damage_modifier : int = 0
	if get_status_count(Restrained) > 0:
		damage_modifier += Restrained.damage_multiplier
	
	if get_status_count(Enrage) > 0:
		damage_modifier += statuses_dict[Enrage.identifier].get_damage_multiplier()
	
	return damage_modifier / 100.0 + 1
