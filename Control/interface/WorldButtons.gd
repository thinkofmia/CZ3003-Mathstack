extends Button

func _on_WorldButton_pressed():
	#Save selected world into variables

	global.worldSelected = self.get_text()
	
	#Debug
	print("World Selected: "+global.worldSelected)
	if global.modeSelected == "Challenge Mode":
		pass
	elif global.modeSelected == "Normal Mode":	
		pass
		#get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
