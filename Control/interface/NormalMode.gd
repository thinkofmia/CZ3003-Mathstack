extends Node

var bg
onready var http : HTTPRequest = $MYHTTPRequest
# Called when the node enters the scene tree for the first time.
func _ready():
	bg = $Background7
	#Start Performance test if true
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	#Set Header
	global.questionCount = 0
	$Header/RichTextLabel.set_text(global.worldSelected+": "+global.difficultySelected)
	changeBg()
	currentDelta = -1
	times = 0
	currentStoryScore = global.storyScore
	currentQuestionCount = 1
	#Find music box
	yield(get_tree().create_timer(1.0), "timeout")
	var musicBox = get_tree().get_root().get_node("World").find_node("MusicBox")
	musicBox.playTrack()
	
	pass # Replace with function body.


#Change Background
func changeBg():
	#Set Background
	bg.setBackground()
	changeMaterial()


#Change Box Material
func changeMaterial():
	var material = $Background7/ColorRect
	match global.worldSelected:
		"World #1":
			material.color = Color(0, 0, 0.8, 1)
		"World #2":
			material.color = Color(0, 0.8, 0, 1)
		"World #3":
			material.color = Color(0, 0.8, 0, 1)
		"World #4":
			material.color = Color(0, 0, 0.8, 1)
		"World #5":
			material.color = Color(0.3, 0.3, 0.3, 1)
		"World #6":
			material.color = Color(0.8, 0.8, 0, 1)
		"World #7":
			material.color = Color(0.8, 0, 0, 1)
		"World #8": ###
			material.color = Color(1, 0, 0, 1)
		"World #9":
			material.color = Color(0.3, 0.3, 0.3, 1)
		"World #10":
			material.color = Color(0.8, 0.8, 0.8, 1)
		_:
			material.color = Color(1, 1, 0, 1)


func changeBg2(selectedBg):
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
var gameEnded = false

func _process(delta):
	
	if (global.questionCount == 10):
		if gameEnded == false:
			doGameEndedProcess()
		gameEnded = true
	
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
	$FinishLabel.text = "Congratulations!" if global.storyScore >= 8 else "Sorry. Please try again!"
	$FinishLabel.show()
	$FinishButton.text = "Next Level" if global.storyScore >= 8 else "Try again"
	
	if global.difficultySelected == "Advanced":
		##not enough characters, so 9 and 10 has nothing
		if global.worldSelected != "World #9" && global.worldSelected != "World #10":
			if (global.storyScore >= 8):
				$FinishButton.text = "Unlocked Character!"
	
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
	global.updateUnlockCharsList(global.save)
	
func _on_QuitButton_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
	pass # Replace with function body.
	


func _on_FinishButton_pressed():
	if global.difficultySelected == "Advanced":
		##not enough characters, so 9 and 10 has nothing
		if global.worldSelected != "World #9" && global.worldSelected != "World #10":
			get_tree().change_scene("res://View/gameModes/NormalModeUnlockCharacter.tscn")
		else:
			get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
	
	else:
		get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")

