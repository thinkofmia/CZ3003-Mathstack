extends Button

#Returns back to Normal Mode -> Select World
func _on_BackButton_pressed():
	get_tree().change_scene("res://menus/gameModes/NormalModeSelectWorld.tscn")
