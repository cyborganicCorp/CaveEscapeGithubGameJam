extends StaticBody2D

func _on_flag_detection_zone_body_entered(body):
	if body.has_method("is_player"):
		print("the player has touched the flag")
		get_tree().change_scene_to_file("res://menu/menu.tscn")

func _on_flag_detection_zone_body_exited(body):
	if body.has_method("is_player"):
		print("the player is no longer touching the flag")
