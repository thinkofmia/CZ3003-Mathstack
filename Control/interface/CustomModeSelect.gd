extends Node

onready var quizId = $PlayBoard/InputRow/InputBox
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_AllQuizButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MyQuizButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeMyQuizzes.tscn")


func _on_SearchButton_pressed():
	global.customID = quizId.get_text()
	print(global.customID)
	get_tree().change_scene("res://View/gameModes/CustomQuizModePreview.tscn")
