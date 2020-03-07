extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Highscore
	$PlayBoard/HighscoreRow/Score.set_text(str(global.highscore))
	#Set Time
	$PlayBoard/TimeElapsedRow/Time.set_text(str(global.time))
