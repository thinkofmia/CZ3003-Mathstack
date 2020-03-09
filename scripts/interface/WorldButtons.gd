extends Button

func _on_WorldButton_pressed():
	#Save selected world into variables
	global.worldSelected = self.get_text()
	
	#Debug
	print("World Selected: "+global.worldSelected)
	if global.modeSelected == "Challenge Mode":
		pass
	elif global.modeSelected == "Normal Mode":	
		get_tree().change_scene("res://menus/gameModes/NormalModeSelectDifficulty.tscn")
