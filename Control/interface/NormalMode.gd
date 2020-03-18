extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Header
	$Header/RichTextLabel.set_text(global.worldSelected+": "+global.difficultySelected)
	changeBg(global.worldSelected.split("#")[1])
	currentDelta = -1
	times = 0
	currentStoryScore = global.storyScore
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
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
var currentStoryScore = global.storyScore
var currentDelta = -1
var times = 0

func _process(delta):
	
	if (currentDelta == delta):
		if (times == 20):
			$CharacterSprite.play("idle")
			currentDelta = -1
			times = 0
		else:
			times = times + 1
	
	if (currentStoryScore != global.storyScore):
		currentDelta = delta
		$CharacterSprite.play("attack")
		currentStoryScore = global.storyScore


func _on_QuitButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
	pass # Replace with function body.
