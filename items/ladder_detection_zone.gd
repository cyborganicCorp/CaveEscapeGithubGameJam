extends Area2D
@onready var stats = PlayerStats


func _on_body_entered(body):
	if body.has_method("is_player"):
		PlayerStats.climbing_state_changed.emit()

func _on_body_exited(body):
	if body.has_method("is_player"):
		PlayerStats.climbing_state_changed.emit()
