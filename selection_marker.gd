extends Node2D
#signal SelectSquare

@onready var menu_blip_sfx = $AudioStreamPlayer


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_right") and position.x < 48:
		#print("right")
		position.x += 16
		menu_blip_sfx.play()
		#print(position.x)
	
	if Input.is_action_just_pressed("ui_left") and position.x > 0:
		#print("left")
		position.x -= 16
		menu_blip_sfx.play()
		#print(position.x)
		
	if Input.is_action_just_pressed("ui_up") and position.y > 0:
		#print("up")
		position.y -= 16
		menu_blip_sfx.play()
		#print(position.y)
		
	if Input.is_action_just_pressed("ui_down") and position.y < 48:
		#print("down")
		position.y += 16
		menu_blip_sfx.play()
		#print(position.y)
