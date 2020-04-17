extends Node

func _on_NormalModeButton_pressed():
	global.difficulty="Normal"
	get_tree().change_scene("res://View/gameModes/NormalModeSelectWorld.tscn")


func _on_ChallengeModeButton_pressed():
	global.difficulty="Challenge"
	get_tree().change_scene("res://View/gameModes/ChallengeModeSelect.tscn")


func _on_CustomModeButton_pressed():
	global.difficulty="Custom"
	get_tree().change_scene("res://View/gameModes/CustomModeSelect.tscn")



func goToMainMenu():
	#Condition
	if (global.accountType == "Teacher"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")


func _on_BackButton_pressed():
	goToMainMenu()
