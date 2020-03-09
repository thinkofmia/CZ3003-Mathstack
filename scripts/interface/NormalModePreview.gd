extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Title
	$PlayBoard/TitleContainer/WorldLabel.set_text(global.worldSelected+":")
	$PlayBoard/TitleContainer/DifficultyLabel.set_text(global.difficultySelected)
	pass # Replace with function body.
