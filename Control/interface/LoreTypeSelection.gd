extends Node

#Return back to others selection scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/Others/OthersSelection.tscn")

#Go to browse music scene
func _on_MusicButton_pressed():
	get_tree().change_scene("res://View/Others/BrowseMusicScene.tscn")

#Go to browse world scene
func _on_WorldsButton_pressed():
	get_tree().change_scene("res://View/Others/BrowseWorldScene.tscn")

#Go to browse character scene
func _on_CharactersButton_pressed():
	get_tree().change_scene("res://View/Others/BrowseCharacterScene.tscn")
