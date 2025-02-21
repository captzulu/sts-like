class_name Location
extends Resource

@export var identifier : String = "spider_cavern"
@export var display_name : String = "Spider Cavern"
@export var tilemap : PackedScene 
@export var completed_level : int = 0
@export var unlocked_level : int = 0
@export var music : AudioStream

func getWavesData(limit : int = 0) -> Dictionary:
	var wave_dict : Dictionary
	var db = DataModule.open_db()

	var query = "SELECT enemyList, waveNumber 
		FROM WavesByLocation
		WHERE locationStringId = '" + self.identifier + "'
		ORDER BY waveNumber"
	if limit != 0:
		query = query + " LIMIT " + limit

	db.query(query)
	var waves : Array = db.query_result
	for wave in waves:
		wave_dict[wave['waveNumber']] = []
		for enemy in wave.enemyList.split(","):
			wave_dict[wave['waveNumber']].append(enemy)
	return wave_dict
	
