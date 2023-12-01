extends Control
@export var end_world_01 : bool = false
@export var end_world_02 : bool = false

@onready var ui_box = $ui_box
@onready var stats = PlayerStats
#@onready var play_again_btn_2 = $"."
#visible

func _ready():
	PlayerStats.connect("no_health", Callable(self, "enableButton"))
	

func enableButton():
	visible = true
	print("the button can now be made visible")

func _on_texture_button_pressed():
	if end_world_01 == true:
		stats.health = 3
		get_tree().change_scene_to_file("res://levels/escape_world_01.tscn")
		return
	if end_world_02 == true:
		stats.health = 3
		get_tree().change_scene_to_file("res://levels/escape_world_02.tscn")
		return
	stats.health = 3
	SaveItem.need_to_reset_level = true
	#SaveItem.tileData = []
	#SaveItem.storedData = false
	#SaveItem.initializeTileDataSave()
	get_tree().change_scene_to_file("res://menu/menu.tscn")
