extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/TopicName.set_text(global.worldSelected)
	changeBg(global.worldSelected.split("#")[1])
	calculateAndSetValueForProgress()
	evaluateUserProgressAndSetButton()
	pass

func changeBg(selectedBg):
	#Hide all bg
	$Background_2.hide()
	$Background_3.hide()
	match int(selectedBg):
		1:
			$TemplateScreen/TextureRect.show()
		2:
			$Background_2.show()
		3:
			$Background_3.show()


func calculateAndSetValueForProgress():
	var currentWorldInt = int(global.worldSelected[len(global.worldSelected) - 1])
	
	if (currentWorldInt == 0):
		currentWorldInt = int(global.worldSelected.substr(len(global.worldSelected) - 2,len(global.worldSelected) - 1))
	
	var userProgress = int(global.save['World' + str(currentWorldInt)].stringValue)
	print(userProgress)
	var finalValue = 0.0
	finalValue = (userProgress / 3.0) * 100
	print(finalValue)
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
