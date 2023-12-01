extends Control

@onready var heart_ui_empty = $HeartUIEmpty
@onready var heart_ui_full = $HeartUIFull

var hearts = 3:
	set(new_value):
		hearts = clamp(new_value, 0 , max_hearts)
		if heart_ui_full != null:
			heart_ui_full.size.x = hearts * 16
			if hearts == 0:
				heart_ui_full.visible = false
	get:
		return hearts

var max_hearts = 3:
	set(new_value):
		max_hearts = max(new_value, 1)
		self.hearts = min(hearts, max_hearts)
		if heart_ui_empty != null:
			heart_ui_empty.size.x = max_hearts * 16
	get:
		return max_hearts

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	heart_ui_full.visible = true
	PlayerStats.connect("max_health_changed", Callable(self, "set_max_hearts"))	
	PlayerStats.connect("health_changed", Callable(self, "custom_hearts"))
	


func custom_hearts(input):
	hearts = input
