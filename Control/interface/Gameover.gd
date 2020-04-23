extends Button

func _on_QuitButton_pressed():
	gameOver()

#Sends the user to the gameover screen
func gameOver():
	get_tree().change_scene("res://View/gameModes/Gameover.tscn")
