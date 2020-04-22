extends Node


# Declare member variables here. Examples:
onready var http : HTTPRequest = $HTTPRequest
onready var students = []
var student_info = []
var student_display
var getStudents=false
var getQuiz=false
var studentList

var newButton = load("res://Model/buttons/interface/userButtons.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Target type as Student
	global.targetType = "Student"
	#Save Node as student List
	studentList = $PlayBoard/ScrollContainer/ListOfStudents
	
	####Requires firebase
	getStudents=true
	Firebase.get_document("users", http)
	yield(get_tree().create_timer(5.0), "timeout")
	#Total Number of Teachers
	#var totalNoUsers = 5
	student_info = (students.values())
	var totalNoUsers = student_info[0].size()
	#Loop based on No of students 
	for i in range (0,totalNoUsers):
		#extract question attribute based on i
		student_display= (student_info[0][i]['fields'])
		print(str(student_display['account'].values()[0]))
		if student_display['account'].values()[0] == "Student":
				#Add new instance
				var addButton = newButton.instance()
				#Change button name to quiz name
				addButton.set_text(str(student_display['nickname'].values()[0]))
				#Add quiz button to the list
				studentList.add_child(addButton)


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/admin/SelectUserType.tscn")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		if getStudents==true:
			#put dictionary into an array
			self.students = response_body
			
			
