extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Brings user to main menu according to account type
func goToMainMenu():
	if (global.accountType == "Teacher"|| global.accountType == "Admin"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")


func _on_BackButton_pressed():
	goToMainMenu() #Return to main menu

#Go to settings Screen
func _on_SettingsButton_pressed():
	get_tree().change_scene("res://View/Screens_Randy/SettingsScreen.tscn")

#Go to lore type screen
func _on_LoreButton_pressed():
	get_tree().change_scene("res://View/Others/LoreTypeSelection.tscn")
