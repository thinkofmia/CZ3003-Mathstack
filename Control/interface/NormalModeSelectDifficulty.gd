extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/TopicName.set_text(global.worldSelected)
	changeBg(global.worldSelected.split("#")[1])
	pass

func changeBg(selectedBg):
	#Hide all bg
	$Background_2.hide()
	$Background_3.hide()
	match int(selectedBg):
		1:
			$TemplateScreen/TextureRect.show()
		2:
			$Background_2.show()
		3:
			$Background_3.show()

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
