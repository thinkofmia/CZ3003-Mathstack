extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Button_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()

#Change volume func
func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label.text = str(round((value + 30) * 2))
	
#Go to Others menu
func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://View/Others/OthersSelection.tscn")
