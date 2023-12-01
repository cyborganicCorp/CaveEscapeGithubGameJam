extends Node2D
var MapTile = preload("res://map_square.tscn")
var SelectionMarker = preload("res://selection_marker.tscn")
var QuestionMark = preload("res://sprites/questionMarkSprite-10-26-23.png")
var MapSprite = preload("res://sprites/mapTilesSpriteSheet-10-26-23.png")
var BlankTile = preload("res://sprites/mapSquarePlaceholder.png")
var TileCount = 0
var TileArray = []
var userSelectionMarker


#signal RequestTileInfo


func _ready():
	userSelectionMarker = SelectionMarker.instantiate()
	add_child(userSelectionMarker)
	#newSelectionMarker.SelectSquare.connect(show_details)
	
	for i in 4:
		for j in 4:
			#create a new instance of a map tile
			var newTile = MapTile.instantiate()
			#give the instance an x and y position based on which iteration it is in the loop
			newTile.position.x = 16 * j
			newTile.position.y = 16 * i
			#assign the new instance a tile count number
			newTile.MapSquareNum = TileCount
			#get a reference to the new tiles sprite 2d component
			var newTileSprite = newTile.get_child(0)
			#set the sprite x and y position for the new tiles image
			#since the map and the map sprite are the same size this works
			newTile.MapTileImgPosition = newTile.position
			
			#newTileSprite.region_rect.position = newTile.position
			#print(newTileSprite.region_rect.position.x = newTile.position.x)
			#print(newTileTexture)
			#give the remaining tiles a question mark sprite
			if TileCount > 0:
				newTileSprite.texture = BlankTile
				#print(newTile.get_child(0).texture)
			
			
			#increase the tile count
			TileCount+=1
			#add the map tile to the menu as a child
			add_child(newTile)
			#add the map tile to the tile array
			TileArray.append(newTile)
			#set which tiles can be selected
			
			#newTile.get_parent().RequestTileInfo.connect(newTile.show_tile_info)
			#print(newTile.get_parent())
	
	TileArray[1].get_child(0).texture = QuestionMark
	TileArray[1].canBeSelected = true
	TileArray[4].get_child(0).texture = QuestionMark
	TileArray[4].canBeSelected = true
	

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		for i in TileArray.size():
			if userSelectionMarker.position == TileArray[i].position:
				print(TileArray[i].MapSquareNum)
				if TileArray[i].canBeSelected == true and TileArray[i].hasBeenSelected == false:
					TileArray[i].get_child(0).texture = MapSprite
					TileArray[i].get_child(0).region_rect.position = TileArray[i].MapTileImgPosition
					TileArray[i].hasBeenSelected = true
					#make the surrounding tiles able to be selected
					#check the tile to the right
					if TileArray[i].MapSquareNum + 1 < 16:
						var tileToTheRight = TileArray[i].MapSquareNum + 1
						if TileArray[tileToTheRight].hasBeenSelected == false:
							#certain numbers cannot be accessed to the right because the numbers wrap from left to right
							if tileToTheRight != 4 and tileToTheRight != 8 and tileToTheRight != 12 and tileToTheRight != 16:
								TileArray[tileToTheRight].canBeSelected = true
								TileArray[tileToTheRight].get_child(0).texture = QuestionMark
					#check the tile to the left
					if TileArray[i].MapSquareNum - 1 > 0:
						var tileToTheLeft = TileArray[i].MapSquareNum - 1
						if TileArray[tileToTheLeft].hasBeenSelected == false:
							#certain numbers cannot be accessed to the left because of number wrap
							if tileToTheLeft != 0 and tileToTheLeft != 3 and tileToTheLeft != 7 and tileToTheLeft != 11:
								TileArray[tileToTheLeft].canBeSelected = true
								TileArray[tileToTheLeft].get_child(0).texture = QuestionMark
					#check the tile below
					if TileArray[i].MapSquareNum + 4 < 16:
						var tileToTheBottom = TileArray[i].MapSquareNum + 4
						if TileArray[tileToTheBottom].hasBeenSelected == false:
							#cut any numbers on the bottom row because they cannot have a tile below them
							if tileToTheBottom < 16:
								TileArray[tileToTheBottom].canBeSelected = true
								TileArray[tileToTheBottom].get_child(0).texture = QuestionMark
					#check the tile above
					if TileArray[i].MapSquareNum - 4 > 0:
						var tileToTheTop = TileArray[i].MapSquareNum - 4
						if TileArray[tileToTheTop]. hasBeenSelected == false:
							#cut any numbers below 0 because the top row cannot have a tile above it
							if tileToTheTop > 0:
								TileArray[tileToTheTop].canBeSelected = true
								TileArray[tileToTheTop].get_child(0).texture = QuestionMark
