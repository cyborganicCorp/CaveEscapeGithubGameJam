extends Node2D

@onready var health_restore_sfx = $health_restore_sfx

func _ready():
	health_restore_sfx.play()

func _on_animated_sprite_2d_animation_finished():
	self.queue_free()
