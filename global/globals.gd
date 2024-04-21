extends Node

var current_location : Location = LOCATION_SPIDER
var cards : Dictionary
var char_stats : CharacterStats
const LOCATION_SPIDER : Location = preload("res://scenes/maps/locations/spider_cavern.tres")
const LOCATION_CYCLOP : Location = preload("res://scenes/maps/locations/cyclop_halls.tres")
const LOCATION_UNDEAD : Location = preload("res://scenes/maps/locations/undead_lair.tres")
const TOOLTIP_HIGHLIGHT_TEXT_COLOR : String = "fcba03"
const TOOLTIP_SPIKE_TEXT_COLOR : String = "3d4445"
const TOOLTIP_POISON_TEXT_COLOR : String = "62c223"
const TOOLTIP_HEAL_TEXT_COLOR : String = "43db1d"
const TOOLTIP_BLOCK_TEXT_COLOR : String = "0044ff"
const TOOLTIP_DAMAGE_TEXT_COLOR : String = "ebc807"
