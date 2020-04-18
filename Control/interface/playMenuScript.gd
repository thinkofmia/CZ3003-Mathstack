extends Node

func _on_NormalModeButton_pressed():
	global.difficulty="Normal"
	$FadeIn.show()
	$FadeIn.fade_in()	



func _on_ChallengeModeButton_pressed():
	global.difficulty="Challenge"
	$FadeIn.show()
	$FadeIn.fade_in()



func _on_CustomModeButton_pressed():
	global.difficulty="Custom"
	$FadeIn.show()
	$FadeIn.fade_in()




func goToMainMenu():
	#Insert get account type here!
	#
	#Condition
	if (global.accountType == "Teacher"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")


func _on_BackButton_pressed():
	goToMainMenu()


func _on_FadeIn_fade_finished():
	match global.difficulty:
		"Normal":
			get_tree().change_scene("res://View/gameModes/NormalModeSelectWorld.tscn")
		"Challenge":
			get_tree().change_scene("res://View/gameModes/ChallengeModeSelect.tscn")
		"Custom":
			get_tree().change_scene("res://View/gameModes/CustomModeSelect.tscn")		
