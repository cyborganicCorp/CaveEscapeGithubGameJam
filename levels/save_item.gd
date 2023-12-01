extends Node2D

var storedData = false
var grid_width = 3
var grid_height = 16
var tileData = []
var selectorPosition = null
var levels_completed : int = 0
var last_selected_level
var need_to_reset_level : bool = false
var easy_available_levels = []
var difficult_available_levels = []
var easy_level_to_replace = null
var difficult_level_to_replace = null


func _ready():
	if storedData == false:
		initializeTileDataSave()
		#print(tileData)


func initializeTileDataSave():
	selectorPosition = null
	for i in grid_height:
		tileData.append([])
		tileData[i].append(null)
		tileData[i].append(null)
		tileData[i].append(null)
		tileData[i].append(null)
		tileData[i].append(null)
		tileData[i].append(null)
		#or j in grid_width:
			#tileData[i][j].append(null)
