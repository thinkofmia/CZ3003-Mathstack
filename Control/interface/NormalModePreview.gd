extends Node
var bg
# Called when the node enters the scene tree for the first time.
func _ready():
	bg =  $Background
	#Set mode select to normal mode
	global.modeSelected = "Normal Mode"
	#Set Title
	$PlayBoard/MarginContainer/VBoxContainer/TitleContainer/WorldLabel.set_text(global.worldSelected+":")
	$PlayBoard/MarginContainer/VBoxContainer/TitleContainer/DifficultyLabel.set_text(global.difficultySelected)
	#Set score
	if (global.difficultySelected == "Primary"):
		$PlayBoard/MarginContainer/VBoxContainer/ScoreRow/StoryScore.set_text(str(global.save['ScoreWorld' + str(global.worldSelected.split("#")[1]) + 'a']['stringValue'])+"/10")
	
	if (global.difficultySelected == "Intermediate"):
		$PlayBoard/MarginContainer/VBoxContainer/ScoreRow/StoryScore.set_text(str(global.save['ScoreWorld' + str(global.worldSelected.split("#")[1]) + 'b']['stringValue'])+"/10")

	if (global.difficultySelected == "Advanced"):
		$PlayBoard/MarginContainer/VBoxContainer/ScoreRow/StoryScore.set_text(str(global.save['ScoreWorld' + str(global.worldSelected.split("#")[1]) + 'c']['stringValue'])+"/10")
	
	changeBg()
	pass # Replace with function body.



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
			
func _on_Button_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModePlayScreen.tscn")
