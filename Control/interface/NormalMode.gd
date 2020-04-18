extends Node

onready var http : HTTPRequest = $MYHTTPRequest
# Called when the node enters the scene tree for the first time.
func _ready():
	#Start Performance test if true
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
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
	$Background4.hide()
	$Background5.hide()
	$Background6.hide()
	match int(selectedBg):
		1:
			$TemplateScreen/TextureRect.show()
		2:
			$Background2.show()
		3:
			$Background3.show()
		4:
			$Background4.show()
		5:
			$Background5.show()
		6:
			$Background6.show()
			


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
	if (global.storyScore >= 8):
		updateFirebaseUserProgress()
	pass
	
func updateFirebaseUserProgress():
	var currentWorldInt = int(global.worldSelected[len(global.worldSelected) - 1])
	
	if (currentWorldInt == 0):
		currentWorldInt = int(global.worldSelected.substr(len(global.worldSelected) - 2,len(global.worldSelected) - 1))
	
	var userProgressInt = int(global.save['World' + str(currentWorldInt)]['stringValue'])
	
	if (global.difficultySelected == "Primary"):
		if (userProgressInt < 1):
			global.save['World' + str(currentWorldInt)]['stringValue'] = "1"
		
		if (int(global.save['ScoreWorld' + str(currentWorldInt) + 'a']['stringValue']) < global.storyScore):
			global.save['ScoreWorld' + str(currentWorldInt) + 'a']['stringValue'] = str(global.storyScore)
		
	if (global.difficultySelected == "Intermediate"):
		if (userProgressInt < 2):
			global.save['World' + str(currentWorldInt)]['stringValue'] = "2"
			
		if (int(global.save['ScoreWorld' + str(currentWorldInt) + 'b']['stringValue']) < global.storyScore):
			global.save['ScoreWorld' + str(currentWorldInt) + 'b']['stringValue'] = str(global.storyScore)

	if (global.difficultySelected == "Advanced"):
		if (userProgressInt < 3):
			global.save['World' + str(currentWorldInt)]['stringValue'] = "3"

		if (int(global.save['ScoreWorld' + str(currentWorldInt) + 'c']['stringValue']) < global.storyScore):
			global.save['ScoreWorld' + str(currentWorldInt) + 'c']['stringValue'] = str(global.storyScore)
	
	Firebase.update_document("SaveData/%s" % str(global.username),global.save,http)	
	
func _on_QuitButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
	pass # Replace with function body.
	


func _on_FinishButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
	pass # Replace with function body.
