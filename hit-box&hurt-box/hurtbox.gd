extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var invincibility_timer = $InvincibilityTimer

signal invincibility_started
signal invincibility_ended

var invincible = false:
	set(new_value):
		invincible = new_value
		if(invincible == true):
			emit_signal("invincibility_started")
		else:
			emit_signal("invincibility_ended")
	get:
		return invincible

func start_invincibility(duration):
	self.invincible = true
	invincibility_timer.start(duration)
	print("invincibility has started")



func _on_timer_timeout():
	self.invincible = false


func _on_invincibility_started():
	collision_shape_2d.set_deferred("disabled", true)



func _on_invincibility_ended():
	collision_shape_2d.set_deferred("disabled", false)
