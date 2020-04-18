extends Button

#Returns back to Custom Mode Select
func _on_BackButton_pressed():
	if global.customViewingStats:
		get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")
		global.customViewingStats = false
	else:
		get_tree().change_scene("res://View/gameModes/CustomModeSelect.tscn")

