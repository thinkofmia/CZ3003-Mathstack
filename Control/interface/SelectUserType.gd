extends Node

#Go to manage database scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/admin/ManageDatabase.tscn")

#Go to select student scene
func _on_Students_pressed():
	get_tree().change_scene("res://View/admin/SelectStudent.tscn")

#Go to select teacher scene
func _on_Teachers_pressed():
	get_tree().change_scene("res://View/admin/SelectTeacher.tscn")
