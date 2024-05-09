extends Node

@export var reward_cards : Dictionary
@export var char_stats : CharacterStats
@export var current_location : Location = LOCATION_SPIDER

const LOCATION_SPIDER : Location = preload("res://resources/locations/spider_cavern.tres")
const LOCATION_CYCLOP : Location = preload("res://resources/locations/cyclop_halls.tres")
const LOCATION_UNDEAD : Location = preload("res://resources/locations/undead_lair.tres")
const MAP_ORDER : Array = [
	LOCATION_SPIDER,
	LOCATION_CYCLOP,
	LOCATION_UNDEAD
]
const TOOLTIP_HIGHLIGHT_TEXT_COLOR : String = "fcba03"
const TOOLTIP_SPIKE_TEXT_COLOR : String = "3d4445"
const TOOLTIP_POISON_TEXT_COLOR : String = "62c223"
const TOOLTIP_HEAL_TEXT_COLOR : String = "43db1d"
const TOOLTIP_BLOCK_TEXT_COLOR : String = "0044ff"
const TOOLTIP_DAMAGE_TEXT_COLOR : String = "ebc807"
