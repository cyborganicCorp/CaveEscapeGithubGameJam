extends Area2D

var damage = 1

func _on_body_entered(body):
	if body.has_method("is_player"):
		print("the spike trap has collided with the player")
