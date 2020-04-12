extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_AddButton_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsSelectWorld.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")


func _on_EditButton_pressed():
	get_tree().change_scene("res://View/teachers/EditQnsSelectWorld.tscn")
