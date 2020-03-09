extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set mode select to normal mode
	global.modeSelected = "Normal Mode"
	#Set Title
	$PlayBoard/TitleContainer/WorldLabel.set_text(global.worldSelected+":")
	$PlayBoard/TitleContainer/DifficultyLabel.set_text(global.difficultySelected)
	#Set score
	$PlayBoard/ScoreRow/StoryScore.set_text(str(global.storyScore)+"/10")
	pass # Replace with function body.
