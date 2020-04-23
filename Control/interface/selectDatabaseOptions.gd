extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.accountType == "Teacher"):
		$PlayBoard/ButtonRow/ManageProfiles.hide()#Hide teachers from normal mode

#Go to select world scene
func _on_EditQuestions_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsSelectWorld.tscn")

func _on_BackButton_pressed():
	goToMainMenu()

#Go back to main menu based on account type
func goToMainMenu():
	#Condition
	if (global.accountType == "Teacher"|| global.accountType == "Admin"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")

#Go to select user type scene
func _on_ManageProfiles_pressed():
	get_tree().change_scene("res://View/admin/SelectUserType.tscn")
