extends Button

#Returns back to play menu
func _on_BackButton_pressed():
	get_tree().change_scene("res://menus/gameModes/PlayMenu.tscn")
