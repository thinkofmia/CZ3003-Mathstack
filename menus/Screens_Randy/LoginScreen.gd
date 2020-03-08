extends Control

var account_type

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LoginButton_pressed():
	account_type = "Teacher"
	if account_type == "Teacher":
		get_tree().change_scene("res://menus/Screens_Randy/MainMenuTeachers.tscn")
	else:	
		get_tree().change_scene("res://menus/Screens_Randy/MainMenu.tscn")


func _on_RegButton_pressed():
	get_tree().change_scene("res://menus/Screens_Randy/NewAccount.tscn")


func _on_ForgotPassButton_pressed():
	get_tree().change_scene("res://menus/Screens_Randy/ForgotPassScreen.tscn")
