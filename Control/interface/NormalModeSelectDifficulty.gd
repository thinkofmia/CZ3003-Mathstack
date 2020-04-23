extends Node

var bg
# Called when the node enters the scene tree for the first time.
func _ready():
	bg = $Background
	#Start test performance if needed
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	$PlayBoard/MarginContainer/VBoxContainer/TopicName.set_text(global.worldSelected)
	changeBg()
	calculateAndSetValueForProgress()
	evaluateUserProgressAndSetButton()
	pass


#Change Background
func changeBg():
	#Set Background
	bg.setBackground()
	changeMaterial()


#Change Box Material
func changeMaterial():
	var material = $Background/ControlBox
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
	$Background_2.hide()
	$Background_3.hide()
	$Background_4.hide()
	$Background_5.hide()
	$Background_6.hide()
	match int(selectedBg):
		1:
			$TemplateScreen/TextureRect.show()
		2:
			$Background_2.show()
		3:
			$Background_3.show()
		4:
			$Background_4.show()
		5:
			$Background_5.show()
		6:
			$Background_6.show()


func calculateAndSetValueForProgress():
	var currentWorldInt = int(global.worldSelected[len(global.worldSelected) - 1])
	
	if (currentWorldInt == 0):
		currentWorldInt = int(global.worldSelected.substr(len(global.worldSelected) - 2,len(global.worldSelected) - 1))
	
	var userProgress = int(global.save['World' + str(currentWorldInt)].stringValue)
	var finalValue = 0.0
	finalValue = (userProgress / 3.0) * 100
	$PlayBoard/MarginContainer/VBoxContainer/CompletionBox/ProgressBar.value = finalValue

func evaluateUserProgressAndSetButton():
	var currentWorldInt = int(global.worldSelected[len(global.worldSelected) - 1])
	
	if (currentWorldInt == 0):
		currentWorldInt = int(global.worldSelected.substr(len(global.worldSelected) - 2,len(global.worldSelected) - 1))
	
	var userProgressInt = int(global.save['World' + str(currentWorldInt)]['stringValue'])
	
	if (userProgressInt == 0):
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/IntermediateButton.hide()
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/AdvancedButton.hide()
	
	if (userProgressInt == 1):
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/AdvancedButton.hide()
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/PrimaryButton.icon = load("res://Model/Object/Tick.png")
	
	elif (userProgressInt == 2):
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/PrimaryButton.icon = load("res://Model/Object/Tick.png")
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/IntermediateButton.icon = load("res://Model/Object/Tick.png")
	
	elif (userProgressInt == 3):
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/PrimaryButton.icon = load("res://Model/Object/Tick.png")
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/IntermediateButton.icon = load("res://Model/Object/Tick.png")
		$PlayBoard/MarginContainer/VBoxContainer/DifficultyDiv/AdvancedButton.icon = load("res://Model/Object/Tick.png")
	#Performance Check
	if (testPerformance.performanceCheck):
		print("Performance Test: Normal Mode - Difficulty Load")
		testPerformance.getTimeTaken()
#Primary Mode Selected
func _on_PrimaryButton_pressed():
	global.difficultySelected = "Primary"
	#Go to Normal Mode Preview
	jumpToNormalModePreview()

#Intermediate Mode Selected
func _on_IntermediateButton_pressed():
	global.difficultySelected = "Intermediate"
	jumpToNormalModePreview()

#Advanced Mode Selected
func _on_AdvancedButton_pressed():
	global.difficultySelected = "Advanced"
	jumpToNormalModePreview()
	
func jumpToNormalModePreview():
	get_tree().change_scene("res://View/gameModes/NormalModePreview.tscn")
