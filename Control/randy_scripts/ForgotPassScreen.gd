extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var email : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/LineEdit


func _ready():
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://View/Screens_Randy/LoginScreen.tscn")


func _on_Button3_pressed():
	var Email = email.text
	Firebase.reset_pw(Email,http)
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://View/Screens_Randy/EmailSuccess.tscn")



func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	print(result_body)
