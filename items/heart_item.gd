extends StaticBody2D
@onready var sparkle_packed : PackedScene = preload("res://items/sparkle_particle.tscn")

var restore_amount : int = 1
var stats = PlayerStats

func _on_area_2d_body_entered(body):
	if(body.has_method("is_player")):
		
		if stats.health < 3:
			stats.health  += restore_amount
			print("restore the players health")
			var sparkle = sparkle_packed.instantiate()
			sparkle.global_position = self.global_position
			get_tree().root.add_child(sparkle)
			self.queue_free()
