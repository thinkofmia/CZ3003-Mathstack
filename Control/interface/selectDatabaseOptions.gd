extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_AddQuestions_pressed():
	pass # Replace with function body.


func _on_BackButton_pressed():
	goToMainMenu()

func goToMainMenu():
	#Condition
	if (global.accountType == "Teacher"|| global.accountType == "Admin"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")
