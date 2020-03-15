extends Button

#Returns back to Normal Mode -> Select World
func _on_AllQuizButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")
