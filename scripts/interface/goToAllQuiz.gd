extends Button

#Returns back to Normal Mode -> Select World
func _on_AllQuizButton_pressed():
	get_tree().change_scene("res://menus/gameModes/CustomModeAllQuizzes.tscn")
