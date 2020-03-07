extends Node

func _on_GodotIcon_pressed():
	global.characterSelected = "Godot"
	print("Godot has been selected!")

func _on_SSIcon_pressed():
	global.characterSelected = "Swee Soldier"
	print("Swee Soldier has been selected!")

func _on_MrIIcon_pressed():
	global.characterSelected = "Mister I"
	print("Mister I has been selected!")
