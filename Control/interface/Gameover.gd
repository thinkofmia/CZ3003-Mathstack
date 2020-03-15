extends Button

#Returns back to play menu
func _on_QuitButton_pressed():
	gameOver()

func gameOver():
	get_tree().change_scene("res://View/gameModes/Gameover.tscn")


