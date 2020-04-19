extends Node


# Declare member variables here. Examples:
var studentList
var newButton = load("res://Model/buttons/interface/userButtons.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Target type as Student
	global.targetType = "Student"
	#Save Node as student List
	studentList = $PlayBoard/ScrollContainer/ListOfStudents
	
	####Requires firebase
	
	#Total Number of students
	var totalNoStudents = 5
	#Loop based on No of students 
	for i in range (0,totalNoStudents):
		#Add new instance
				var addButton = newButton.instance()
				#Change button name to quiz name
				addButton.set_text("Student #"+str(i))
				#Add quiz button to the list
				studentList.add_child(addButton)


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/admin/SelectUserType.tscn")
