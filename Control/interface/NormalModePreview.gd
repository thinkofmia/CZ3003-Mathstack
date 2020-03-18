extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set mode select to normal mode
	global.modeSelected = "Normal Mode"
	#Set Title
	$PlayBoard/MarginContainer/VBoxContainer/TitleContainer/WorldLabel.set_text(global.worldSelected+":")
	$PlayBoard/MarginContainer/VBoxContainer/TitleContainer/DifficultyLabel.set_text(global.difficultySelected)
	#Set score
	$PlayBoard/MarginContainer/VBoxContainer/ScoreRow/StoryScore.set_text(str(global.storyScore)+"/10")
	changeBg(global.worldSelected.split("#")[1])
	pass # Replace with function body.

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
			
func _on_Button_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModePlayScreen.tscn")
