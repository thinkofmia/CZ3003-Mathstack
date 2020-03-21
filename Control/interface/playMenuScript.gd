extends Node

func _on_NormalModeButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectWorld.tscn")


func _on_ChallengeModeButton_pressed():
	get_tree().change_scene("res://View/gameModes/ChallengeModeSelect.tscn")


func _on_CustomModeButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeSelect.tscn")
