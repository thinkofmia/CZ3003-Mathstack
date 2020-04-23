extends Button

func _on_PlayButton_pressed():
	if global.modeSelected == "Custom Mode": #If custom mode, go to custom play screen
		get_tree().change_scene("res://View/gameModes/CustomPlayScreen.tscn")
	else:# If challenge mode, go to challenge play screen
		get_tree().change_scene("res://View/gameModes/ChallengePlayScreen.tscn")
