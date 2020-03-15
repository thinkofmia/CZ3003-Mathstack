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
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModePlayScreen.tscn")
