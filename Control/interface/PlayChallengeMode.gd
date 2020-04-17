extends Button

#Starts Challenge/Custom Mode
func _on_PlayButton_pressed():
	if global.modeSelected == "All Custom" or global.modeSelected == "My Custom":
		get_tree().change_scene("res://View/gameModes/CustomPlayScreen.tscn")
	else:
		get_tree().change_scene("res://View/gameModes/ChallengePlayScreen.tscn")
