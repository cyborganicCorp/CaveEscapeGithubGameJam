extends Node2D

@onready var label = $Label
@onready var animation_player = $AnimationPlayer

var count: float = 0.0
var letterTotal: int = 0
var completed_percent : float = 0
var completed_string : String = ""
var outro_dialogue: String = ""
var string_to_print: String = ""

func _ready():
	label.text = string_to_print
	completed_percent = round((float(SaveItem.levels_completed) / 16) * 100)
	completed_string = str(completed_percent)
	outro_dialogue = "At last, a way out of here! You explored " + completed_string + "% of the cave."
	

func _physics_process(delta):
	count += delta
	if count > 0.08 and letterTotal < outro_dialogue.length():
		string_to_print = string_to_print.insert(string_to_print.length(), outro_dialogue[letterTotal])  
		label.text = string_to_print
		letterTotal += 1
		count = 0.0
		if letterTotal >= outro_dialogue.length():
			$Timer.start()
			

func start_fade():
	animation_player.play("end_game_fade")

func _on_animation_player_animation_finished(anim_name):
	SaveItem.tileData = []
	SaveItem.storedData = false
	SaveItem.initializeTileDataSave()
	get_tree().change_scene_to_file("res://levels/splash_screen.tscn")
	


func _on_timer_timeout():
	start_fade()
	
