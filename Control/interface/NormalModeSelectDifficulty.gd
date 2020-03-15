extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	print(global.worldSelected)
	$PlayBoard/MarginContainer/VBoxContainer/TopicName.set_text(global.worldSelected)
	pass

#Primary Mode Selected
func _on_PrimaryButton_pressed():
	global.difficultySelected = "Primary"
	#Go to Normal Mode Preview
	jumpToNormalModePreview()

#Intermediate Mode Selected
func _on_IntermediateButton_pressed():
	global.difficultySelected = "Intermediate"
	jumpToNormalModePreview()

#Advanced Mode Selected
func _on_AdvancedButton_pressed():
	global.difficultySelected = "Advanced"
	jumpToNormalModePreview()
	
func jumpToNormalModePreview():
	get_tree().change_scene("res://View/gameModes/NormalModePreview.tscn")
