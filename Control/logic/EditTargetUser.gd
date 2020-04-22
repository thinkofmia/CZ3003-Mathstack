extends Control


# Declare member variables here. Examples:
onready var http : HTTPRequest = $HTTPRequest
onready var nickname = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/HeaderRow/NicknameEdit
onready var accountType = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/AccountRow/AccountOptions
onready var email = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/EmailRow/EmailTag
onready var school = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/SchoolRow/SchoolOption
onready var selectedClass = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/ClassRow/ClassOption
var account_array = ["Student","Teacher","Admin"]
var class_array = ["SS1","SS2","SSP1"]
var school_array = ["NTU", "NUS", "SMU"]
var information_sent := false
var account
var classId
var schoolId
var getEmail

onready var users= []
var user_info = []
var user_display
var getUsers=false
var userList

var profile := {
	"account":{},
	"nickname":{},
	"schoolId":{},
	"classId":{}
} 

# Called when the node enters the scene tree for the first time.
func _ready():
	#Pop up display
	$PopUpControl.hide()
	#Initalization
	fillOptions()
	getUsers=true
	Firebase.get_document("users", http)
	yield(get_tree().create_timer(5.0), "timeout")
	#Total Number of Teachers
	#var totalNoUsers = 5
	user_info = (users.values())
	var totalNoUsers = user_info[0].size()
	#Loop based on No of students 
	for i in range (0,totalNoUsers):
		#extract question attribute based on i
		user_display= (user_info[0][i]['fields'])
		if user_display['nickname'].values()[0] == global.selectUserEdit:
				getEmail = user_info[0][i]['name']
				var a = getEmail.find_last("/")
				var b = getEmail.length()
				getEmail = getEmail.substr((a+1),(b-a+1))
				email.text=(getEmail)
				account = user_display['account'].values()[0]
				print(account)
				if account=="Student":
					accountType.select(0)
				elif account=="Teacher":
					accountType.select(1)
				elif account=="Admin":
					accountType.select(2)
				nickname.text=user_display['nickname'].values()[0]
				schoolId = user_display['schoolId'].values()[0]
				school.select(int(schoolId))
				classId = user_display['classId'].values()[0]
				selectedClass.select(int(classId))
				continue				
	#TIME OUT
	yield(get_tree().create_timer(2.0), "timeout")

func fillOptions(): 
	#fill School Array
	for item in school_array:
		school.add_item(item)
	#fill Class Array
	for item in class_array:
		selectedClass.add_item(item)
	#fill Account Array
	for item in account_array:
		accountType.add_item(item)

func _on_Cancel_pressed(): #Return to list of users
	if (global.targetType == "Student"):
		get_tree().change_scene("res://View/admin/SelectStudent.tscn")
	else:
		get_tree().change_scene("res://View/admin/SelectTeacher.tscn")


func _on_Confirm_pressed():
	#Show Pop up display
	$PopUpControl.show()
	#Update firebase here
	#set profile attributes
	profile.nickname = { "stringValue": nickname.text }
	var acc = accountType.get_selected_id()
	profile.account = { "stringValue": accountType.get_item_text(acc)}
	profile.schoolId = { "integerValue": school.get_selected_id() }
	profile.classId = { "integerValue": selectedClass.get_selected_id() }
	#http request to update user profile
	Firebase.update_document("users/%s" % getEmail, profile, http)
	information_sent = true
	#TIME OUT
	yield(get_tree().create_timer(3.0), "timeout")
	$PopUpControl.hide()


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		if getUsers==true:
			#put dictionary into an array
			self.users = response_body

func set_profile(value: Dictionary) -> void:
	#display the profile attributes
	profile = value
	account = profile.account.stringValue
	if account=="Student":
		accountType.select(0)
	elif account=="Teacher":
		accountType.select(1)
	elif account=="Admin":
		accountType.select(2)
	nickname.text=profile.nickname.stringValue
	schoolId = profile.schoolId.integerValue
	school.select(int(schoolId))
	classId = profile.classId.integerValue
	selectedClass.select(int(classId))
