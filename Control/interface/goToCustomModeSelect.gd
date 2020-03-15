extends Button

#Returns back to Custom Mode Select
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeSelect.tscn")

