extends Node

func _on_NormalModeButton_pressed():
	global.difficulty="Normal"
	get_tree().change_scene("res://View/gameModes/NormalModeSelectWorld.tscn")


func _on_ChallengeModeButton_pressed():
	global.difficulty="Challenge"
	get_tree().change_scene("res://View/gameModes/ChallengeModeSelect.tscn")


func _on_CustomModeButton_pressed():
	global.difficulty="Custom"
	get_tree().change_scene("res://View/gameModes/CustomModeSelect.tscn")
