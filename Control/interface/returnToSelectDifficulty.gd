extends Button

#Returns back to select difficulty
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
