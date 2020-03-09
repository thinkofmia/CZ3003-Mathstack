extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/TopicName.set_text(global.worldSelected)
	pass

#Primary Mode Selected
func _on_PrimaryButton_pressed():
	global.difficultySelected = "Primary"
	#Go to Normal Mode Preview
	get_tree().change_scene("res://menus/gameModes/NormalModePreview.tscn")

#Intermediate Mode Selected
func _on_IntermediateButton_pressed():
	global.difficultySelected = "Intermediate"
	get_tree().change_scene("res://menus/gameModes/NormalModePreview.tscn")

#Advanced Mode Selected
func _on_AdvancedButton_pressed():
	global.difficultySelected = "Advanced"
	get_tree().change_scene("res://menus/gameModes/NormalModePreview.tscn")
