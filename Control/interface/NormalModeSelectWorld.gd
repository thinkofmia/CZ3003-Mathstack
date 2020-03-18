extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentSelectedWorld = "World #0"
onready var http : HTTPRequest = $HTTPRequest

# Called when the node enters the scene tree for the first time.
func _ready():
	global.modeSelected = "Normal Mode"
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.worldSelected != currentSelectedWorld:
		Firebase.save_document("normalmodeprogress",{"progress":{"integerValue":6}}, http)
		changeBg(global.worldSelected.split("#")[1])
		currentSelectedWorld = global.worldSelected
		$NextButton/NextButtonLabel.text = "Enter " + global.worldSelected
		
func changeBg(selectedBg):
	#Hide all bg
	$Background2.hide()
	$Background3.hide()
	match int(selectedBg):
		1:
			$TemplateScreen/TextureRect.show()
		2:
			$Background2.show()
		3:
			$Background3.show()


func _on_NextButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
