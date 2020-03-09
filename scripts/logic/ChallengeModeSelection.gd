extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set mode select to challenge mode
	global.modeSelected = "Challenge Mode"

func _on_GodotIcon_pressed():
	global.characterSelected = "Godot"
	print("Godot has been selected!")

func _on_SSIcon_pressed():
	global.characterSelected = "Swee Soldier"
	print("Swee Soldier has been selected!")

func _on_MrIIcon_pressed():
	global.characterSelected = "Mister I"
	print("Mister I has been selected!")
