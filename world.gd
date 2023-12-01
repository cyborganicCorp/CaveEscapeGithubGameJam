extends Node2D

@onready var menu = preload("res://menu/menu.tscn")
@onready var world_01 = preload("res://levels/world_01.tscn")
@onready var flag = preload("res://items/flag.tscn")

var menuMaze
var world1

func _ready():
	#print(menu.ChangeWorld)
	var menuMaze = menu.instantiate()
	#world1 = world_01.instantiate()
	#menuMaze.position = Vector2(160 - 32,90 - 32)
	add_child(menuMaze)
	#menuMaze.ChangeWorld.connect(change_world)

#func change_world():
#	print("change world function was called")
#	remove_child(menuMaze)
#	add_child(world1)
#	#remove_child(menu)
