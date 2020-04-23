extends Node


# Declare member variables here. Examples:
onready var http : HTTPRequest = $HTTPRequest
onready var teachers= []
var teacher_info = []
var teacher_display
var getTeachers=false
var teacherList

var newButton = load("res://Model/buttons/interface/userButtons.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Target type as Student
	global.targetType = "Teacher"
	#Save Node as student List
	teacherList = $PlayBoard/ScrollContainer/ListOfTeachers
	
	####Requires firebase
	getTeachers=true
	Firebase.get_document("users", http)
	yield(get_tree().create_timer(5.0), "timeout")
	#Total Number of Teachers
	#var totalNoUsers = 5
	teacher_info = (teachers.values())
	var totalNoUsers = teacher_info[0].size()
	#Loop based on No of teachers
	for i in range (0,totalNoUsers):
		#extract question attribute based on i
		teacher_display= (teacher_info[0][i]['fields'])
		print(str(teacher_display['account'].values()[0]))
		if teacher_display['account'].values()[0] == "Teacher":
				#Add new instance
				var addButton = newButton.instance()
				#Change button name to quiz name
				addButton.set_text(str(teacher_display['nickname'].values()[0]))
				#Add quiz button to the list
				teacherList.add_child(addButton)


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/admin/SelectUserType.tscn")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		if getTeachers==true:
			#put dictionary into an array
			self.teachers = response_body
