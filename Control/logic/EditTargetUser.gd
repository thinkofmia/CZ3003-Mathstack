extends Control


# Declare member variables here. Examples:
onready var nickname = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/HeaderRow/NicknameEdit
onready var accountType = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/AccountRow/AccountOptions
onready var email = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/EmailRow/EmailTag
onready var school = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/SchoolRow/SchoolOption
onready var selectedClass = $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions/ClassRow/ClassOption
var account_array = ["Student","Teacher","Admin"]
var class_array = ["SS1","SS2","SSP1"]
var school_array = ["NTU", "NUS", "SMU"]


# Called when the node enters the scene tree for the first time.
func _ready():
	#Pop up display
	$PopUpControl.hide()
	#Initalization
	fillOptions()
	#TIME OUT
	yield(get_tree().create_timer(2.0), "timeout")
	#Fake Default Values - Replace with firebase values here
	nickname.set_text("Target")
	accountType.select(int(0))
	email.set_text("fakeemail@faker.com")
	school.select(int(0))
	selectedClass.select(int(0))

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
	#
	#TIME OUT
	yield(get_tree().create_timer(3.0), "timeout")
	$PopUpControl.hide()
