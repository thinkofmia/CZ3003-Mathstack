extends Node

#Return back to others selection scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/Others/OthersSelection.tscn")

#Go to browse music scene
func _on_MusicButton_pressed():
	get_tree().change_scene("res://View/Others/BrowseMusicScene.tscn")
