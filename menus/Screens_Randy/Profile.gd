extends Control

var scene_path_to_load
var account_type


func _ready():
	for button in $TextureRect/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	account_type = "Teacher"
	if scene_path_to_load == "res://menus/Screens_Randy/MainMenu.tscn":
		if account_type == "Teacher":
			scene_path_to_load = "res://menus/Screens_Randy/MainMenuTeachers.tscn"
	get_tree().change_scene(scene_path_to_load)
