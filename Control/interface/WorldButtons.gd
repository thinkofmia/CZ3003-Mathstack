extends Button

func _on_WorldButton_pressed():
	#Save selected world into variables
	global.worldSelected = self.get_text()
	#Debug
	print("World Selected: "+global.worldSelected)
