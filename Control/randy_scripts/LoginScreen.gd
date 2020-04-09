extends Control

var account_type
var error_text
var loginBool=false
var getDataBool=false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit
onready var password : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit2

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	error_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/ErrorMessage
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	#Enter shortcut disabled due to bugs
	#if Input.is_action_just_pressed("ui_accept") and $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MarginContainer/LoginButton.is_visible():
	#	print("Login button visible")
	#	_on_LoginButton_pressed()
		
	pass


func _on_LoginButton_pressed():
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/MarginContainer/LoginButton.hide()
	global.username = username
	var email_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit.get_text()
	var password_text = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit2.get_text()
	
	if email_text == "": # or if email_address is not valid in DB
		error_text.set_text("Please enter a valid email address.")
		error_text.show()
		$TextureRect/MarginContainer/MarginContainer/VBoxContainer/MarginContainer/LoginButton.show()
	
	elif password_text == "":
		error_text.set_text("Please enter your password.")
		error_text.show()
		$TextureRect/MarginContainer/MarginContainer/VBoxContainer/MarginContainer/LoginButton.show()

	else:		
		loginBool=true
		#http request to login
		Firebase.login(username.text, password.text, http)
		yield(get_tree().create_timer(2.0), "timeout")
		getDataBool=true
		#http request to get user progress
		Firebase.get_save("SaveData/%s" % Firebase.user_info.email, http)
	#account_type = "Teacher"
	#if account_type == "Teacher":
	#	get_tree().change_scene("res://menus/Screens_Randy/MainMenuTeachers.tscn")
	#else:	
	#	get_tree().change_scene("res://menus/Screens_Randy/MainMenu.tscn")


func _on_RegButton_pressed():
	get_tree().change_scene("res://View/Screens_Randy/NewAccount.tscn")


func _on_ForgotPassButton_pressed():
	get_tree().change_scene("res://View/Screens_Randy/ForgotPassScreen.tscn")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	#error
	print("Sending In progress"+str(response_code))
	if response_code == 200:
		if loginBool:
				
				#added this to be able to access username easily
				global.username = username.text
		if getDataBool:
			getDataBool = false
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
		loginBool = false
	elif response_code == 400:
		if loginBool:
				print("This Works")
				error_text.set_text("Invalid account credemtials. Please try again.")
				error_text.show()
				loginBool = false
				$TextureRect/MarginContainer/MarginContainer/VBoxContainer/MarginContainer/LoginButton.show()
	else:
		if loginBool:
				print("This Works")
				error_text.set_text("Invalid account credemtials. Please try again.")
				error_text.show()
				loginBool = false
				$TextureRect/MarginContainer/MarginContainer/VBoxContainer/MarginContainer/LoginButton.show()
