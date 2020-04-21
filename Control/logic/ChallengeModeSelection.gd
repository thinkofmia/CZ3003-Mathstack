extends Node
var selectedBg = 1
var musicBox

# Called when the node enters the scene tree for the first time.
func _ready():
	#Find music box
	musicBox = get_tree().get_root().get_node("World").find_node("MusicBox")
	#Set mode select to challenge mode
	global.modeSelected = "Challenge Mode"
	#Hide health and power button
	$SelectedCharacter/healthBar.hide()
	$SelectedCharacter/PowerButton.hide()
	getWorld()
	#Initialize worlds visited
	global.worldsVisited = []
	#Timeout
	yield(get_tree().create_timer(1.0), "timeout")
	#Play Music
	musicBox.playTrack()

func getWorld():
	match global.worldSelected:
		"World #1":
			selectedBg = 1
		"World #2":
			selectedBg = 2
		"World #3":
			selectedBg = 3
		"World #4":
			selectedBg = 4
		"World #5":
			selectedBg = 5
		"World #6":
			selectedBg = 6
		"World #7":
			selectedBg = 1
		"World #8":
			selectedBg = 2
		"World #9":
			selectedBg = 3
		"World #10":
			selectedBg = 4
		_:
			selectedBg = 5
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

func _on_WorldButton_pressed():
	#Set bg
	selectedBg = 1
	changeBg()
	
func changeBg():
	#Play Music
	musicBox.playTrack()
	#Hide all bg
	$TemplateScreen/TextureRect.hide()
	$Background2.hide()
	$Background3.hide()
	$Background4.hide()
	$Background5.hide()
	$Background6.hide()
	match selectedBg:
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
		_:
			$Background6.show()


func _on_WorldButton2_pressed():
	selectedBg = 2
	changeBg()


func _on_WorldButton4_pressed():
	selectedBg = 3
	changeBg()


func _on_WorldButton3_pressed():
	selectedBg = 4
	changeBg()


func _on_WorldButton8_pressed():
	selectedBg = 5
	changeBg()


func _on_WorldButton7_pressed():
	selectedBg = 6
	changeBg()


func _on_WorldButton6_pressed():
	selectedBg = 1
	changeBg()


func _on_WorldButton5_pressed():
	selectedBg = 2
	changeBg()


func _on_WorldButton10_pressed():
	selectedBg = 3
	changeBg()


func _on_WorldButton9_pressed():
	selectedBg = 4
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
