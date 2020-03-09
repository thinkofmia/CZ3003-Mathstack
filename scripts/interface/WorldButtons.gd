extends Button

func _on_WorldButton_pressed():
	#Save selected world into variables
	global.worldSelected = $Label.get_text()
	
	#Debug
	print("World Selected: "+global.worldSelected)
	get_tree().change_scene("res://menus/gameModes/NormalModeSelectDifficulty.tscn")
