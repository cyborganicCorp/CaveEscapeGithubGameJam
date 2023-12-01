extends CharacterBody2D

var SPEED : float = 400

@onready var timer = %Timer

var direction : Vector2

func _ready():
	direction = Vector2(1,0).rotated(rotation)

#the arrow projectile needs to fly forward at a constant speed
#it needs to destroy itself after it collides with something

func _physics_process(delta):
	#print(direction)
	velocity =  SPEED * direction
	move_and_slide()

func _on_arrow_hurtbox_body_entered(body):
	timer.start()

func _on_timer_timeout():
	self.queue_free()
