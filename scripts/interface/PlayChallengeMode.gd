extends Button

#Starts Challenge Mode
func _on_PlayButton_pressed():
	get_tree().change_scene("res://menus/gameModes/ChallengePlayScreen.tscn")
