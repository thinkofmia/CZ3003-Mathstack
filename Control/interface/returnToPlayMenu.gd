extends Button

#Returns back to play menu
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/gameModes/PlayMenu.tscn")

#Returns back to play menu
func _on_QuitButton_pressed():
	get_tree().change_scene("res://View/gameModes/PlayMenu.tscn")
