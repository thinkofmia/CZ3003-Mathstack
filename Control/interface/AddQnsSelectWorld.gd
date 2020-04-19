extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/LeftContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed")
	for button in $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/RightContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed")
		
func _on_Button_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsDetails.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()




func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://View/admin/ManageDatabase.tscn")
