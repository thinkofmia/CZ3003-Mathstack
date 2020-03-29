extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var myQuizzes = ["Custom Quiz 1","Faker","ADD ME"]
var quizList 

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set mode selected to be my custom quiz
	global.modeSelected = "My Custom"
	#Set Quiz List
	quizList = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes
	#Load Button Object
	$AddButton/Label.set_text("Add")
	var newButton = load("res://Model/buttons/gameModeButtons/CustomQuizButton.tscn")
	#For loop for array of total quizzes player made
	for i in range(0,myQuizzes.size()):
		#Add new instance
		var addButton = newButton.instance()
		#Change button name to quiz name
		addButton.set_text(myQuizzes[i])
		#Add quiz button to the list
		quizList.add_child(addButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AddButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeEdit.tscn")
