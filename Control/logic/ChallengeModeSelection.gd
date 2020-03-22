extends Node
var selectedBg = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set mode select to challenge mode
	global.modeSelected = "Challenge Mode"
	#Hide health and power button
	$SelectedCharacter/healthBar.hide()
	$SelectedCharacter/PowerButton.hide()

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
	selectedBg = 1
	changeBg()
	
func changeBg():
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
	get_tree().change_scene("res://View/gameModes/ChallengePlayScreen.tscn")


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
