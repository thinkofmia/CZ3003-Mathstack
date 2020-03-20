extends Control

var account_type

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit
onready var password : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var loginBool=false
var getDataBool=false

func _on_LoginButton_pressed():
	loginBool=true
	Firebase.login(username.text, password.text, http)
	yield(get_tree().create_timer(2.0), "timeout")
	getDataBool=true
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
	if response_code == 200:
		if loginBool:
				loginBool = false
				#added this to be able to access username easily
				global.username = username.text
		if getDataBool:
			getDataBool = false
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
