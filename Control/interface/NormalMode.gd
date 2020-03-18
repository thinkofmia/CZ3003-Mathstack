extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Header
	global.questionCount = 0
	$Header/RichTextLabel.set_text(global.worldSelected+": "+global.difficultySelected)
	changeBg(global.worldSelected.split("#")[1])
	currentDelta = -1
	times = 0
	currentStoryScore = global.storyScore
	currentQuestionCount = 1
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
var currentQuestionCount = 1

func _process(delta):
	
	if (global.questionCount == 10):
		doGameEndedProcess()
	
	else:
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
			currentQuestionCount = currentQuestionCount + 1
			currentStoryScore = global.storyScore
	


func doGameEndedProcess():
	$QuestionMenu.hide()
	$FinishLabel.text = "Congratulations!" if currentStoryScore >= 8 else "Sorry. Please try again!"
	$FinishLabel.show()
	$FinishButton.text = "Next Level" if currentStoryScore >= 8 else "Try again"
	$FinishButton.show()
	pass

func _on_QuitButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
	pass # Replace with function body.
