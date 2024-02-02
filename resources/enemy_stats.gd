class_name EnemyStats
extends Stats

@export var ai : PackedScene
@export var identifier : String
@export var is_boss : bool
@export var scale : Vector2 = Vector2(1, 1)

func create_instance(health_variance : float = 0) -> Resource:
	var instance : Stats = self.duplicate() as Stats
	instance.max_health = max_health
	if health_variance > 0 and is_boss == false:
		var variance : int = roundi(clampf(health_variance, 0, 1) * max_health)
		instance.max_health = randi_range(max_health - variance, max_health + variance)
	instance.health = max_health
	instance.block = 0
	instance.statuses_dict =  {}
	return instance
