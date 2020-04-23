extends Node

var selectedBg = 1 #Bg Selected Variable
onready var musicBox = get_tree().get_root().get_node("World").find_node("MusicBox") #Variable Node for music box
onready var bg = get_tree().get_root().get_node("World").find_node("Background") #Variable Node for back ground
onready var character = $SelectedCharacter # Get character node
onready var material = $Background/ControlBox #Get control box node

#Get Nodes for Character Icons
onready var sweeSoldier = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/SSIcon
onready var humbleBee = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/HBIcon
onready var riderRabbit = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/RRIcon
onready var zestyZombie = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/ZZIcon
onready var carefulCyborg = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/CCIcon
onready var deadlyDino = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/DDIcon
onready var fireFox = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/FFIcon
onready var misterI = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/MrIIcon
onready var wittyWitch = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/WWIcon
onready var tickyTroll = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/CharacterSelectRow2/TTIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	global.modeSelected = "Challenge Mode" #Set Mode Selected to be Challenge Mode
	#Hide health and power button
	character.hpBar.hide()
	character.power.hide()
	global.worldsVisited = []#Initialize worlds visited
	bg.setBackground()#Set Background
	yield(get_tree().create_timer(1.0), "timeout")#Timeout by 1sec
	changeBg()#Update Bg accordingly
	showCharacters()#Show Character Icons accordingly

#Show character icons based on account type
func showCharacters():
	#Check if account type is Student, Teacher or Administrator
	if (global.accountType == "Student"): #If Account type is student
		#For loop to show the respective unlocked characters icon
		for character in global.getListOfUnlockedCharactersName():
			match character:
				"Swee Soldier":
					sweeSoldier.show()
				"Mister I":
					misterI.show()
				"Humble B":
					humbleBee.show()
				"Rider Rabbit":
					riderRabbit.show()
				"Zesty Zombie":
					zestyZombie.show()
				"Careful Cyborg":
					carefulCyborg.show()
				"Deadly Dino":
					deadlyDino.show()
				"Fire Fox":
					fireFox.show()
				"Witty Witch":
					wittyWitch.show()
				"Ticky Troll":
					tickyTroll.show()
	else:#If account type is a Teacher or Admin
		showAllCharacters()
		
#Show all characters icons
func showAllCharacters():
	sweeSoldier.show()
	misterI.show()
	humbleBee.show()
	riderRabbit.show()
	zestyZombie.show()
	carefulCyborg.show()
	deadlyDino.show()
	fireFox.show()
	wittyWitch.show()
	tickyTroll.show()	

#Update Character selection
func updateCharacter():
	character.displayCharacter()#Show the updated Character
	print(global.characterSelected+" has been selected!")#Debug
	
#If the user clicks on Godog Icon
func _on_GodotIcon_pressed():
	global.characterSelected = "Godog" #Changes character to Godog
	updateCharacter()#Update Changes
	
#If user clicks on Swee Soldier Icon
func _on_SSIcon_pressed():
	global.characterSelected = "Swee Soldier"#Changes Character to Swee Soldier
	updateCharacter()

#If user selects Mister I
func _on_MrIIcon_pressed():
	global.characterSelected = "Mister I" #Changes character to Mister I
	updateCharacter()

#If user selects Humble B
func _on_HBIcon_pressed():
	global.characterSelected = "Humble B" #Changes character to Humble B
	updateCharacter()

#If user selects Rider Rabbit
func _on_RRIcon_pressed():
	global.characterSelected = "Rider Rabbit" #Changes Character to Rider Rabbit
	updateCharacter()

#If World #1 was selected
func _on_WorldButton_pressed():
	#Set world to World #1
	global.worldSelected = "World #1"
	#Set bg
	changeBg()

#Change Background
func changeBg():
	#Set Background
	bg.setBackground()
	#Change menu box color
	changeMaterial()
	#Play Music
	musicBox.playTrack()

#Change Box Material
func changeMaterial():
	match global.worldSelected:#Check which world user is in and append color accordingly
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

#Selecting World 2
func _on_WorldButton2_pressed():
	global.worldSelected = "World #2"
	changeBg() #Changes Background accordingly
	

#Selecting World 4
func _on_WorldButton4_pressed():
	global.worldSelected = "World #4"
	changeBg() #Changes Background accordingly

#Selecting World 3
func _on_WorldButton3_pressed():
	global.worldSelected = "World #3"
	changeBg() #Changes Background accordingly

#Selecting World 8
func _on_WorldButton8_pressed():
	global.worldSelected = "World #8"
	changeBg()#Changes Background accordingly

#Selecting World 7
func _on_WorldButton7_pressed():
	global.worldSelected = "World #7"
	changeBg()#Changes Background accordingly

#Selecting World 6
func _on_WorldButton6_pressed():
	global.worldSelected = "World #6"
	changeBg()#Changes Background accordingly

#Selecting World 5
func _on_WorldButton5_pressed():
	global.worldSelected = "World #5"
	changeBg()#Changes Background accordingly

#Selecting World 10
func _on_WorldButton10_pressed():
	global.worldSelected = "World #10"
	changeBg()#Changes Background accordingly

#Selecting World 9
func _on_WorldButton9_pressed():
	global.worldSelected = "World #9"
	changeBg()#Changes Background accordingly

#When Play button is pressed
func _on_Play_pressed():
	#Conduct Performance check if mode is on
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	#Transfer user to Challenge Mode: Play Scree
	get_tree().change_scene("res://View/gameModes/ChallengePlayScreen.tscn")
	#Performance check Ends
	if (testPerformance.performanceCheck):
		print("Performance Test: Challenge Mode Starting")
		testPerformance.getTimeTaken()

#Select Zesty Zombie as Character
func _on_ZZIcon_pressed():
	global.characterSelected = "Zesty Zombie"
	updateCharacter()

#Selecting Careful Cyborg as Character
func _on_CCIcon_pressed():
	global.characterSelected = "Careful Cyborg"
	updateCharacter()

#Selecting Danger Dino as Character
func _on_DDIcon_pressed():
	global.characterSelected = "Deadly Dino"
	updateCharacter()

#Selecting Fire Fox as Character
func _on_FFIcon_pressed():
	global.characterSelected = "Fire Fox"
	updateCharacter()

#Selecting Witty Witch as character
func _on_WWIcon_pressed():
	global.characterSelected = "Witty Witch"
	updateCharacter()

#Selecting Ticky Troll as character
func _on_TTIcon_pressed():
	global.characterSelected = "Ticky Troll"
	updateCharacter()
