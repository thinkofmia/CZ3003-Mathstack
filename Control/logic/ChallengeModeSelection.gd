extends Node
var selectedBg = 1
var musicBox
var bg

# Called when the node enters the scene tree for the first time.
func _ready():
	#Find Bg node
	bg = get_tree().get_root().get_node("World").find_node("Background")
	#Find music box
	musicBox = get_tree().get_root().get_node("World").find_node("MusicBox")
	#Set mode select to challenge mode
	global.modeSelected = "Challenge Mode"
	#Hide health and power button
	$SelectedCharacter/healthBar.hide()
	$SelectedCharacter/PowerButton.hide()
	#Initialize worlds visited
	global.worldsVisited = []
	#Timeout
	yield(get_tree().create_timer(1.0), "timeout")
	changeBg()

func _on_GodotIcon_pressed():
	global.characterSelected = "Godot"
	$SelectedCharacter.displayCharacter()
	print("Godot has been selected!")

func _on_SSIcon_pressed():
	global.characterSelected = "Swee Soldier"
	$SelectedCharacter.displayCharacter()
	print("Swee Soldier has been selected!")

func _on_MrIIcon_pressed():
	global.characterSelected = "Mister I"
	$SelectedCharacter.displayCharacter()
	print("Mister I has been selected!")

func _on_HBIcon_pressed():
	global.characterSelected = "Humble B"
	$SelectedCharacter.displayCharacter()
	print("Humble B has been selected!")

func _on_RRIcon_pressed():
	global.characterSelected = "Rider Rabbit"
	$SelectedCharacter.displayCharacter()
	print("Rider Rabbit has been selected!")

#World Button 1
func _on_WorldButton_pressed():
	global.worldSelected = "World #1"
	#Set bg
	changeBg()

#Change Background
func changeBg():
	#Set Background
	bg.setBackground()
	changeMaterial()
	#Play Music
	musicBox.playTrack()

#Change Box Material
func changeMaterial():
	var material = $Background/ControlBox
	match global.worldSelected:
		"World #1":
			material.color = Color(0, 0, 1, 1)
		"World #2":
			material.color = Color(0, 1, 0, 1)
		"World #3":
			material.color = Color(0, 1, 0, 1)
		"World #4":
			material.color = Color(0, 0, 1, 1)
		"World #5":
			material.color = Color(0.3, 0.3, 0.3, 1)
		"World #6":
			material.color = Color(1, 1, 0, 1)
		_:
			material.color = Color(1, 1, 0, 1)

#World Button 2
func _on_WorldButton2_pressed():
	global.worldSelected = "World #2"
	changeBg()
	

#World Button 4
func _on_WorldButton4_pressed():
	global.worldSelected = "World #4"
	changeBg()

#World Button 3
func _on_WorldButton3_pressed():
	global.worldSelected = "World #3"
	changeBg()

#World Button 8
func _on_WorldButton8_pressed():
	global.worldSelected = "World #8"
	changeBg()

#World Button 7
func _on_WorldButton7_pressed():
	global.worldSelected = "World #7"
	changeBg()

#World Button 6
func _on_WorldButton6_pressed():
	global.worldSelected = "World #6"
	changeBg()

#World Button 5
func _on_WorldButton5_pressed():
	global.worldSelected = "World #5"
	changeBg()

#World Button 10
func _on_WorldButton10_pressed():
	global.worldSelected = "World #10"
	changeBg()

#World Button 9
func _on_WorldButton9_pressed():
	global.worldSelected = "World #9"
	changeBg()

func _on_Play_pressed():
	#Performance check
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	get_tree().change_scene("res://View/gameModes/ChallengePlayScreen.tscn")
	#Performance check
	if (testPerformance.performanceCheck):
		print("Performance Test: Challenge Mode Starting")
		testPerformance.getTimeTaken()


func _on_ZZIcon_pressed():
	global.characterSelected = "Zesty Zombie"
	$SelectedCharacter.displayCharacter()
	print("Zesty Zombie has been selected!")


func _on_CCIcon_pressed():
	global.characterSelected = "Careful Cyborg"
	$SelectedCharacter.displayCharacter()
	print("Careful Cyborg has been selected!")


func _on_DDIcon_pressed():
	global.characterSelected = "Deadly Dino"
	$SelectedCharacter.displayCharacter()
	print("Deadly Dino has been selected!")


func _on_FFIcon_pressed():
	global.characterSelected = "Fire Fox"
	$SelectedCharacter.displayCharacter()
	print("Fire Fox has been selected!")
