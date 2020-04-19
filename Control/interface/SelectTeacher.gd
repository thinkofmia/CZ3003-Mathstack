extends Node


# Declare member variables here. Examples:
var teacherList
var newButton = load("res://Model/buttons/interface/userButtons.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Target type as Student
	global.targetType = "Teacher"
	#Save Node as student List
	teacherList = $PlayBoard/ScrollContainer/ListOfTeachers
	
	####Requires firebase
	
	#Total Number of Teachers
	var totalNoUsers = 5
	#Loop based on No of students 
	for i in range (0,totalNoUsers):
		#Add new instance
				var addButton = newButton.instance()
				#Change button name to quiz name
				addButton.set_text("Teacher #"+str(i))
				#Add quiz button to the list
				teacherList.add_child(addButton)


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/admin/SelectUserType.tscn")
