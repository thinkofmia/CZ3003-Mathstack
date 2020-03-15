extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)


func _on_Button4_pressed():
	get_tree().change_scene("res://View/Screens_Randy/Profile.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://View/gameModes/PlayMenu.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://View/teachers/LeaderboardScene.tscn")


func _on_Button5_pressed():
	#get_tree().change_scene("res://menus/Screens_Randy/SettingsScreen.tscn")
	#For debugging
	get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")


func _on_Button6_pressed():
	get_tree().change_scene("res://View/Screens_Randy/LoginScreen.tscn")


func _on_StatsBtn_pressed():
#For debugging
	get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")
