extends CharacterBody2D

@export var move_speed : float = 20.0

@export var start_point : float = 0.0
@export var end_point : float = -1280.0
@export var movement_type : String = "Vertical"
@onready var timer = $Timer
var move_direction : int = 1

enum{
	MOVING_TO_END,
	MOVING_TO_START,
	WAITING
}

var current_state = MOVING_TO_END
var next_state = MOVING_TO_START


func _physics_process(delta):
	handle_movement(current_state, delta)


func handle_movement(state, delta):
	if state == WAITING:
		return
	if state == MOVING_TO_END:
		if position.y > end_point:
			position.y -= move_speed * delta
		

#if the position is less than the end point it continues to move towards the end point
#once it reaches the end point it starts a timer and waits for a period of time
#after that it changes direction and moves back towards its original position


func _on_timer_timeout():
	print("the timer has ended")
	if next_state == MOVING_TO_START:
		current_state = MOVING_TO_START
		next_state = MOVING_TO_END
	else:
		current_state = MOVING_TO_END
		next_state = MOVING_TO_START
