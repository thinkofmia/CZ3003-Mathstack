extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set time
	$Header/RichTextLabel.set_text("Gameover")
	#Set Highscore
	$PlayBoard/HighscoreRow/Score.set_text(str(global.highscore))
	$PlayBoard/TimeElapsedRow/Time.set_text(str(global.time))
