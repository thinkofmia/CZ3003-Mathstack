extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var account_type
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	account_type = "Teacher"
	if account_type == "Teacher":
		get_tree().change_scene("res://menus/Screens_Randy/MainMenuTeachers.tscn")
	else:	
		get_tree().change_scene("res://menus/Screens_Randy/MainMenu.tscn")


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label.text = str(round((value + 72) / 0.78))
	
