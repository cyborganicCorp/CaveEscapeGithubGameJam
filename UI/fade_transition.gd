extends Node2D

@onready var transition = $Transition

func start_fade():
	transition.play("fade_out")

func start_fade_in():
	transition.play("fade_in")


func _on_transition_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://levels/end_game_world.tscn")
