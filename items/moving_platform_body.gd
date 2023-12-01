extends CharacterBody2D

@export var move_speed : float = 20.0

@export var start_point : float = 0.0
@export var end_point : float = 110.0
@export var movement_type : String = "Horizontal"
@onready var timer = $Timer
var move_direction : int = 1
var tracked_position

enum{
	MOVING_TO_END,
	MOVING_TO_START,
	WAITING
}

var current_state = MOVING_TO_END
var next_state = MOVING_TO_START

func _ready():
	if movement_type == "Horizontal":
		tracked_position = position.x
		return
	else:
		tracked_position = position.y


func _physics_process(delta):
	handle_movement(current_state, delta)


func handle_movement(state, delta):
	if movement_type == "Horizontal":
		if state == WAITING:
			return
		if state == MOVING_TO_END:
			if position.x < end_point:
				position.x += move_speed * delta
			if position.x >= end_point:
				current_state = WAITING
				timer.start()
		if state == MOVING_TO_START:
			if position.x > start_point:
				position.x -= move_speed * delta
			if position.x <= start_point:
				current_state = WAITING
				timer.start()
	if movement_type == "Vertical":
		if state == WAITING:
			return
		if state == MOVING_TO_END:
			if position.y > end_point:
				position.y -= move_speed * delta
			if position.y <= end_point:
				current_state = WAITING
				timer.start()
		if state == MOVING_TO_START:
			if position.y < start_point:
				position.y += move_speed * delta
			if position.y >= start_point:
				current_state = WAITING
				timer.start()

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
