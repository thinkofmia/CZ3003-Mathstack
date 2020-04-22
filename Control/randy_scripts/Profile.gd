extends Control

onready var http : HTTPRequest = $HTTPRequest
#Social Media
var message

onready var email : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Leaderboard
onready var account : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Play
onready var nickname : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/Label
onready var school : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Profile
onready var class1 : Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/Exit
onready var char1 :	Label = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/Button/Label
onready var character = $Character
onready var fullname = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/FullNameLabel
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
	email.text = "Email: " + Firebase.user_info.email
	account.text = "Account: "+ global.accountType
	#test for global save data
	#char1.text = global.save.World1.stringValue
	#Hide Character details
	character.get_node("healthBar").hide()
	character.get_node("PowerButton").hide()
	yield(get_tree().create_timer(3), "timeout")
	message = "Hey there! "+nickname.get_text()+" of class "+class1.get_text()+". I am using "+global.characterSelected+"! "

func goToMainMenu():
	#Condition
	if (global.accountType == "Teacher"|| global.accountType == "Admin"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")

func hideButtons():
	$FBButton.hide()
	$RedditButton.hide()
	$WAButton.hide()
	$ShareButton.hide()
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/Button2.hide()

func showButtons():
	$FBButton.show()
	$RedditButton.show()
	$WAButton.show()
	$ShareButton.show()
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/Button2.show()

func _on_Button_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	goToMainMenu()

func setFullName(field):
	#Set full name
	var fullNameExists = false
	for key in field:
		print(key)
		if (key=="fullname"):
			fullNameExists = true
			
		if (fullNameExists):
			fullname.set_text(field['fullname'].values()[0])
		else:
			fullname.set_text(field['nickname'].values()[0])

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
			setFullName(self.profile)
			

func set_profile(value: Dictionary) -> void:
	profile = value
	account.text = "Account: %s" % str(profile.account.stringValue)
	nickname.text = str(profile.nickname.stringValue)
	school.text = "School: %s" % str(school_array[int(profile.schoolId.integerValue)])
	class1.text = "Class: %s" % str(class_array[int(profile.classId.integerValue)])
	#class1.select(1)


func _on_Button2_pressed():
	get_tree().change_scene("res://View/Screens_Randy/EditProfile.tscn")



func _on_ShareButton_pressed():
	var tweet = "https://twitter.com/intent/tweet?text="
	OS.shell_open(tweet+message)

func _on_WAButton_pressed():
	var url = "https://wa.me/?text="
	OS.shell_open(url+message)

func _on_RedditButton_pressed():
	var url = "https://reddit.com/submit?title="
	OS.shell_open(url+message)

func _on_FBButton_pressed():
	var facebook = "http://www.facebook.com/sharer.php?u=ntulearn.ntu.edu.sg&t=MyHighScore&ps=100&p[summary]="
	OS.shell_open(facebook+message)
