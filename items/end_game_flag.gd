extends StaticBody2D

var collidedWithPlayer = false
@onready var transition_parent = $CanvasLayer/transition_parent

func _physics_process(delta):
	if collidedWithPlayer == true:
		print("player has touched the flag")

func _on_end_game_flag_detection_zone_body_entered(body):
	if body.has_method("is_player"):
		print("the player has touched the flag")
		transition_parent.start_fade()

func _on_end_game_flag_detection_zone_body_exited(body):
	if body.has_method("is_player"):
		print("the player is no longer touching the flag")
