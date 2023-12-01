extends Node2D

@onready var label = $Label
@onready var start_game_timer = $start_game_timer

var count: float = 0.0
var letterTotal: int = 0
var intro_sentence: String = "You awaken surrounded by darkness. With no recollection of how you got here. You begin searching for the way out."
var string_to_print: String = ""

func _ready():
	label.text = string_to_print

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://menu/menu.tscn")
	count += delta
	if count > 0.08 and letterTotal < intro_sentence.length():
		string_to_print = string_to_print.insert(string_to_print.length(), intro_sentence[letterTotal])  
		label.text = string_to_print
		letterTotal += 1
		count = 0.0
		if letterTotal >= intro_sentence.length():
			start_game_timer.start()
			return

func _on_start_game_timer_timeout():
	get_tree().change_scene_to_file("res://menu/menu.tscn")
