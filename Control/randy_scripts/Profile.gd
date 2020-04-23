extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label
onready var account : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Play
onready var nickname : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Leaderboard
onready var school : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Profile
onready var class1 : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Exit
onready var char1 :	Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/Button/Label
var scene_path_to_load
var account_type

var profile := {
	"account":{},
	"nickname":{},
	"school":{},
	"classId":{}
} setget set_profile

var class_array = ["SS1","SS2","SSP1"]
var school_array = ["NTU", "NUS", "SMU"]

func _ready():
	#http request to get user profile	
	Firebase.get_document("users/%s" % global.username, http)
	username.text = Firebase.user_info.email
	#test for global save data
	#char1.text = global.save.World1.stringValue
<<<<<<< Updated upstream
=======
	#Hide Character details
	character.get_node("healthBar").hide()
	character.get_node("PowerButton").hide()
	yield(get_tree().create_timer(3), "timeout")
	message = "Hey there! This is "+nickname.get_text()+" ("+class1.get_text()+") and I am using "+global.characterSelected+" on MathStack! "
	#message = "Hey there! "+nickname.get_text()+" of class "+class1.get_text()+". I am using "+global.characterSelected+"! "
>>>>>>> Stashed changes

func goToMainMenu():
	#Insert get account type here!
	#
	#Condition
	if (global.accountType == "Teacher"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")
	
func _on_Button_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	goToMainMenu()
	#account_type = "Teacher"
	#if scene_path_to_load == "res://menus/Screens_Randy/MainMenu.tscn":
	#	if account_type == "Teacher":
	#		scene_path_to_load = "res://View/Screens_Randy/MainMenuTeachers.tscn"
	#get_tree().change_scene(scene_path_to_load)


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		#error
		404:
			return
		#success
		200:
			#invvoke set method of the profile
			#loading the response into the fields	
			self.profile = result_body.fields

func set_profile(value: Dictionary) -> void:
	profile = value
	account.text = "Account: %s" % str(profile.account.stringValue)
	nickname.text = "Nickname: %s" % str(profile.nickname.stringValue)
	school.text = "School: %s" % str(school_array[int(profile.schoolId.integerValue)])
	class1.text = "Class: %s" % str(class_array[int(profile.classId.integerValue)])
	#class1.select(1)


func _on_Button2_pressed():
	get_tree().change_scene("res://View/Screens_Randy/EditProfile.tscn")
