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
	get_tree().change_scene("res://menus/Screens_Randy/Profile.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://menus/gameModes/PlayMenu.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://menus/Screens_Randy/LeaderboardScreen.tscn")


func _on_Button5_pressed():
	get_tree().change_scene("res://menus/Screens_Randy/SettingsScreen.tscn")


func _on_Button6_pressed():
	get_tree().change_scene("res://menus/Screens_Randy/LoginScreen.tscn")
