extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit
onready var password : LineEdit = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/LineEdit2
onready var school : OptionButton = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/OptionButton3
onready var class1 : OptionButton = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/OptionButton2


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
	Firebase.register(username.text, password.text, http)
	#get_tree().change_scene("res://menus/Screens_Randy/RegisterSuccess.tscn")
	#zfCt7yOk8TQ1f7QcPegfnEpDnJf2

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code == 200:
		get_tree().change_scene("res://View/Screens_Randy/RegisterSuccess.tscn")


func _on_OptionButton3_item_selected(id):
	pass # Replace with function body.
