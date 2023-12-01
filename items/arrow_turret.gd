extends Node2D

@onready var spawn_point = $spawn_point
@onready var timer = $Timer
@onready var arrow_turret_sfx = $arrowTurretSFX
@export var arrow : PackedScene
@export var turret_firing_time : float = 1

func _ready():
	timer.wait_time = turret_firing_time
	timer.start()

func shoot_arrow():
	var new_arrow = arrow.instantiate()
	new_arrow.global_position = spawn_point.global_position
	new_arrow.rotation = rotation
	get_tree().root.add_child(new_arrow)
	timer.start()
	arrow_turret_sfx.play()

func _on_timer_timeout():
	shoot_arrow()
