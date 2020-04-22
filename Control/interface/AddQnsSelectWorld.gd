extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/LeftContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed")
	for button in $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/RightContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed")
		
func goToEditDetails():
	print("Working")
	get_tree().change_scene("res://View/teachers/SelectQuestion.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()




func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://View/admin/ManageDatabase.tscn")


func _on_WorldButton_1_pressed():
	global.worldSelected = "World #1"
	goToEditDetails()


func _on_WorldButton_3_pressed():
	global.worldSelected = "World #3"
	goToEditDetails()


func _on_WorldButton_5_pressed():
	global.worldSelected = "World #5"
	goToEditDetails()


func _on_WorldButton_7_pressed():
	global.worldSelected = "World #7"
	goToEditDetails()


func _on_WorldButton_9_pressed():
	global.worldSelected = "World #9"
	goToEditDetails()


func _on_WorldButton_2_pressed():
	global.worldSelected = "World #2"
	goToEditDetails()


func _on_WorldButton_4_pressed():
	global.worldSelected = "World #4"
	goToEditDetails()


func _on_WorldButton_6_pressed():
	global.worldSelected = "World #6"
	goToEditDetails()


func _on_WorldButton_8_pressed():
	global.worldSelected = "World #8"
	goToEditDetails()


func _on_WorldButton_10_pressed():
	global.worldSelected = "World #10"
	goToEditDetails()
