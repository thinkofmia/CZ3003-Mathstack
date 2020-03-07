extends Node

func _on_GodotIcon_pressed():
	global.characterSelected = "Godot"
	print("Godot has been selected!")

func _on_SSIcon_pressed():
	global.characterSelected = "Swee Soldier"
	print("Swee Soldier has been selected!")
