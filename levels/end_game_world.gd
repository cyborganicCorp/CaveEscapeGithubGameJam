extends Node2D

@onready var transition_parent = $CanvasLayer/transition_parent

func _ready():
	transition_parent.start_fade_in()
