extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit
onready var password : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_pressed():
	get_tree().change_scene("res://menus/Screens_Randy/LoginScreen.tscn")


func _on_Button_pressed():
	Firebase.register(username.text, password.text, http)
	#get_tree().change_scene("res://menus/Screens_Randy/RegisterSuccess.tscn")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code == 200:
		get_tree().change_scene("res://menus/Screens_Randy/RegisterSuccess.tscn")
