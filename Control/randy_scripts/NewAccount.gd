extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/EmailText
onready var password : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/PasswordText
onready var school : OptionButton = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/SchoolSelect
onready var class1 : OptionButton = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/ClassSelect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	add_school()
	add_class()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var school_array = ["NTU", "NUS", "SMU"]
var class_array = ["1","2","3"]


func add_school():
	for item in school_array:
		school.add_item(item)

func add_class():
	for item in class_array:
		class1.add_item(item)
		
func _on_Button2_pressed():
	get_tree().change_scene("res://View/Screens_Randy/LoginScreen.tscn")


func _on_Button_pressed():
	var errorMessage = ""
	var invalid = false
	var email_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/EmailText.get_text()
	var password_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/PasswordText.get_text()
	var nickname_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/NicknameText.get_text()
	var teachers_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/TeachersText.get_text()
	var error_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/ErrorMessage
	
	if not "@" in email_text:
		errorMessage += "Invalid email. "
		invalid = true		
	#if email_text found in DB:
	#	errorMessage += "Email address already taken."
	if password_text.length() < 8:
		errorMessage += "Password should be at least 8 characters long. "
		invalid = true
	
	var password_contains_digit = false
	#var password_contains_special = false
	
	for character in password_text:
		if character.is_valid_integer():
			password_contains_digit = true
			
	if !password_contains_digit:
		errorMessage += "Password should contain a number. "
		invalid = true

	if invalid == true:
		error_text.set_text(errorMessage)
		error_text.show()
	
	else:		
		Firebase.register(username.text, password.text, http)
	#get_tree().change_scene("res://menus/Screens_Randy/RegisterSuccess.tscn")
	#zfCt7yOk8TQ1f7QcPegfnEpDnJf2

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code == 200:
		get_tree().change_scene("res://View/Screens_Randy/RegisterSuccess.tscn")


func _on_OptionButton3_item_selected(id):
	pass # Replace with function body.

