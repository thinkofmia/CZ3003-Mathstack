extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Header
	$Header/RichTextLabel.set_text(global.worldSelected+": "+global.difficultySelected)
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
	pass # Replace with function body.
