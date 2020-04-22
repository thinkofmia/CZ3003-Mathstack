extends Control

var scene_path_to_load

#Character Icons
onready var sweeSoldier = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/SSIcon
onready var humbleBee = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/HBIcon
onready var riderRabbit = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/RRIcon
onready var zestyZombie = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/ZZIcon
onready var carefulCyborg = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/CCIcon
onready var deadlyDino = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/DDIcon
onready var fireFox = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/FFIcon
onready var misterI = $ScrollContainer/MenuOptions/ScrollContainer/CharacterSelectRow/MrIIcon


onready var http : HTTPRequest = $HTTPRequest
onready var account : Label = $ScrollContainer/MenuOptions/Account
onready var nickname : LineEdit = $NicknameEdit
onready var username : LineEdit = $ScrollContainer/MenuOptions/EmailRow/EmailEdit
onready var school : Label = $ScrollContainer/MenuOptions/School
onready var class1 : OptionButton = $ScrollContainer/MenuOptions/ClassRow/OptionButton
onready var fullname = $ScrollContainer/MenuOptions/FullnameRow/FullnameEdit
var information_sent := false

var classId
var class_array = ["SS1","SS2","SSP1"]
var school_array = ["NTU", "NUS", "SMU"]

var profile := {
	"account":{},
	"nickname":{},
	"school":{},
	"classId":{}
} setget set_profile

func add_class():
	for item in class_array:
		class1.add_item(item)

func _ready():	
	$ButtonsRow.hide()
	#http request to get user profile
	Firebase.get_document("users/%s" % Firebase.user_info.email, http)
	username.text = Firebase.user_info.email
	add_class()
	yield(get_tree().create_timer(2.0), "timeout")
	#Show character icons
	showCharacters()
	$ButtonsRow.show()

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)

#func on_item_selected(id):
	#return dropdown.get_item_text(id)

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
			fullname.set_text("Jane Doe")

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		#error
		404:
			return
		#success
		200:
			if information_sent:
				information_sent = false
			#invvoke set method of the profile
			#loading the response into the fields	
			self.profile = result_body.fields
			setFullName(self.profile)
	
func set_profile(value: Dictionary) -> void:
	#display the profile attributes
	profile = value
	account.text = "Account: %s" % str(profile.account.stringValue)
	nickname.text=profile.nickname.stringValue
	school.text = "School: %s" % str(school_array[int(profile.schoolId.integerValue)])
	classId = profile.classId.integerValue
	class1.select(int(classId))
	#class1.select(1)




func _on_ConfirmButton_pressed(): #When confirm button pressed
	#set profile attributes
	if (fullname.get_text()!=""):
		profile.fullname = {"stringValue": fullname.get_text()}
	profile.character = {"stringValue": global.characterSelected}
	profile.nickname = { "stringValue": nickname.text }
	#profile.school = {"stringValue": str(school_array[int(profile.schoolId.integerValue)])}
	profile.classId = { "integerValue": class1.get_selected_id() }
	#http request to update user profile
	Firebase.update_document("users/%s" % Firebase.user_info.email, profile, http)
	information_sent = true
	#Auto Exit
	yield(get_tree().create_timer(2.0), "timeout")
	_on_CancelButton_pressed()


func _on_CancelButton_pressed():
	get_tree().change_scene("res://View/Screens_Randy/Profile.tscn")

func _on_GodotIcon_pressed():
	global.characterSelected = "Godot"
	$SelectedCharacter.displayCharacter()
	print("Godot has been selected!")

func _on_SSIcon_pressed():
	global.characterSelected = "Swee Soldier"
	$SelectedCharacter.displayCharacter()
	print("Swee Soldier has been selected!")

func _on_MrIIcon_pressed():
	global.characterSelected = "Mister I"
	$SelectedCharacter.displayCharacter()
	print("Mister I has been selected!")

func _on_HBIcon_pressed():
	global.characterSelected = "Humble B"
	$SelectedCharacter.displayCharacter()
	print("Humble B has been selected!")

func _on_RRIcon_pressed():
	global.characterSelected = "Rider Rabbit"
	$SelectedCharacter.displayCharacter()
	print("Rider Rabbit has been selected!")
	
func showCharacters():
	print(global.getListOfUnlockedCharactersName())
	for character in global.getListOfUnlockedCharactersName():
		match character:
			"Swee Soldier":
				sweeSoldier.show()
			"Mister I":
				misterI.show()
			"Humble B":
				humbleBee.show()
			"Rider Rabbit":
				riderRabbit.show()
			"Zesty Zombie":
				zestyZombie.show()
			"Careful Cyborg":
				carefulCyborg.show()
			"Deadly Dino":
				deadlyDino.show()
			"Fire Fox":
				fireFox.show()

func _on_ZZIcon_pressed():
	global.characterSelected = "Zesty Zombie"
	$SelectedCharacter.displayCharacter()
	print("Zesty Zombie has been selected!")


func _on_CCIcon_pressed():
	global.characterSelected = "Careful Cyborg"
	$SelectedCharacter.displayCharacter()
	print("Careful Cyborg has been selected!")


func _on_DDIcon_pressed():
	global.characterSelected = "Deadly Dino"
	$SelectedCharacter.displayCharacter()
	print("Deadly Dino has been selected!")


func _on_FFIcon_pressed():
	global.characterSelected = "Fire Fox"
	$SelectedCharacter.displayCharacter()
	print("Fire Fox has been selected!")
