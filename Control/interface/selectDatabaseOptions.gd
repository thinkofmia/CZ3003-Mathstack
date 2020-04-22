extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.accountType == "Teacher"):
		$PlayBoard/ButtonRow/ManageProfiles.hide()#Teachers don't have access


func _on_EditQuestions_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsSelectWorld.tscn")


func _on_BackButton_pressed():
	goToMainMenu()

func goToMainMenu():
	#Condition
	if (global.accountType == "Teacher"|| global.accountType == "Admin"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")


func _on_ManageProfiles_pressed():
	get_tree().change_scene("res://View/admin/SelectUserType.tscn")
