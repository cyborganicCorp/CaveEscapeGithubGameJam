extends CharacterBody2D
class_name SpikeTurtle
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#print(is_on_floor())
	
	apply_gravity(delta)
	
	move_and_slide()
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	elif velocity.x < 0:
		$Sprite2D.flip_h = false


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y = 100
		#print(velocity.y)
	if is_on_floor():
		velocity.y = 0
