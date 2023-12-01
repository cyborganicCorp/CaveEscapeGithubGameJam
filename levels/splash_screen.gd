extends Node2D
var count: float = 0.0

func _ready():
	$AnimatedSprite2D.self_modulate.a = 0

func _physics_process(delta):
	count += delta
	if count < 2:
		$AnimatedSprite2D.self_modulate.a += delta
	else:
		if $AnimatedSprite2D.self_modulate.a > 0:
			$AnimatedSprite2D.self_modulate.a -= delta
	if count > 5:
		get_tree().change_scene_to_file("res://levels/intro_scene.tscn")
