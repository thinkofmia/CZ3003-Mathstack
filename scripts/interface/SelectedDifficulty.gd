extends Button

#Returns back to play menu
func _on_DifficultyButton_pressed():
	get_tree().change_scene("res://menus/gameModes/NormalModePreview.tscn")
