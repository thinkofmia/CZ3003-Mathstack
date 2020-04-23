extends Node

#Go to choose mode for statistics scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")

#Go to choose by class scene
func _on_ChooseByClass_pressed():
	get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")

#Go to choose by individual scene
func _on_ChooseByIndividual_pressed(): #View Statistics based on individual
	get_tree().change_scene("res://View/teachers/ViewStudent.tscn")

#Go to choose by overall scene
func _on_ChooseByOverall_pressed():
	global.viewingOverallStats = true
	get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")
