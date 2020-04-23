extends Node

onready var quizId = $PlayBoard/InputRow/InputBox

#If all quiz selected, go to view all quiz scene
func _on_AllQuizButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")

#When click, go to view my quiz scene
func _on_MyQuizButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeMyQuizzes.tscn")

#When click, search for the custom quiz and go to it
func _on_SearchButton_pressed():
	global.customID = quizId.get_text()
	get_tree().change_scene("res://View/gameModes/CustomQuizModePreview.tscn")
