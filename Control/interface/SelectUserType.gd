extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_BackButton_pressed():
	get_tree().change_scene("res://View/admin/ManageDatabase.tscn")



func _on_Students_pressed():
	get_tree().change_scene("res://View/admin/SelectStudent.tscn")


func _on_Teachers_pressed():
	get_tree().change_scene("res://View/admin/SelectTeacher.tscn")
