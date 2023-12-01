extends Node2D

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal climbing_state_changed

var max_health := 3:
	set(value):
		max_health = value
		self.health = min(health, max_health)
		emit_signal("max_health_changed", max_health)

var health = max_health:
	set(value):
		health = value
		emit_signal("health_changed", health)
		if health <= 0:
			emit_signal("no_health")
	get:
		return health

func _ready():
	self.health = max_health
