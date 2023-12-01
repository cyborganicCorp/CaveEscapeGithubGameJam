extends Control

@onready var ui_box = $ui_box
@onready var stats = PlayerStats


func _ready():
	PlayerStats.connect("no_health", Callable(self, "enableButton"))
	#print("attempting to connect to the no health signal")
	#print(get_tree().current_scene.get_node("Player/RemoteTransform2D").remote_path)

func _on_button_pressed():
	print("the play again button has been pressed")
	stats.health = 3
	SaveItem.need_to_reset_level = true
	#SaveItem.tileData = []
	#SaveItem.storedData = false
	#SaveItem.initializeTileDataSave()
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func enableButton():
	#self.position = get_tree().current_scene.get_node("Camera2D").position
	#ui_box.visible = false
	ui_box.visible = true
	print("the button can now be made visible")

