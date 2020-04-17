extends Control

var scene_path_to_load

func _ready():
	for button in $TextureRect/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)


func _on_Normal_pressed():
	get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")


func _on_Leaderboard_pressed():
	get_tree().change_scene("res://View/teachers/LeaderboardScene.tscn")


func _on_Custom_pressed():
	global.customViewingStats = true
	get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")
