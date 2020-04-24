extends Node

#Nodes
onready var material = $Background/ControlBox #Get control box node
onready var bg = $Background #Get background node
onready var musicBox = $MusicBox #Get music box node
onready var selectHeader = $PlayBoard/CharacterSelectRow/CharacterLabel #Get title node
onready var text= $PlayBoard/ScrollContainer/Text #Get text node

#Character
onready var character = $DisplayCharacter #Get character node
onready var	wittyWitch = $DisplayCharacter/WWSprite
onready var tickyTroll = $DisplayCharacter/TTSprite
onready var sweeSoldier = $DisplayCharacter/SSSprite
onready var misterI = $DisplayCharacter/MrISprite
onready var humbleB = $DisplayCharacter/HBSprite
onready var riderRabbit = $DisplayCharacter/RRSprite
onready var zestyZombie = $DisplayCharacter/ZZSprite
onready var carefulCyborg = $DisplayCharacter/CCSprite
onready var deadlyDino = $DisplayCharacter/DDSprite
onready var fireFox = $DisplayCharacter/FFSprite
onready var godog = $DisplayCharacter/GodogSprite

#Boss Sprites
onready var seaplusplus = $DisplayCharacter/Seaplusplus
onready var goldminator = $DisplayCharacter/Goldminator
onready var burnbie = $DisplayCharacter/Burnbie
onready var darknight = $DisplayCharacter/Darknight

var selected = "Witty Witch"#Selection var for character

# Called when the node enters the scene tree for the first time.
func _ready():
	selectHeader.set_text("Select a Character")#Set text to choose a character
	text.set_text("Waiting for character selection. ")#Default selection text
	setupCharacter()#Setup display for character
	showCharacter()#Display character
	yield(get_tree().create_timer(1.0), "timeout")#Timeout 1 s
	updateText() #Update information text
	characterAnimation()#Set characters animation

#Change Background
func changeBg():
	bg.setBackground()#Set Background
	changeMaterial()#Change menu box color
	musicBox.playTrack()#Play Music

func hideAllCharacters():#Hide all characters
	wittyWitch.hide()
	tickyTroll.hide()
	sweeSoldier.hide()
	misterI.hide()
	humbleB.hide()
	riderRabbit.hide()
	zestyZombie.hide()
	carefulCyborg.hide()
	deadlyDino.hide()
	fireFox.hide()
	godog.hide()
	seaplusplus.hide()
	goldminator.hide()
	burnbie.hide()
	darknight.hide()

func showCharacter():#Show selected character
	hideAllCharacters()#Hide all characters
	match selected:
		"Witty Witch":
			changeBg()
			wittyWitch.show()
		"Ticky Troll":
			changeBg()
			tickyTroll.show()
		"Swee Soldier":
			changeBg()
			sweeSoldier.show()
		"Mister I":
			changeBg()
			misterI.show()
		"Humble B":
			changeBg()
			humbleB.show()
		"Rider Rabbit":
			changeBg()
			riderRabbit.show()
		"Zesty Zombie":
			changeBg()
			zestyZombie.show()
		"Careful Cyborg":
			changeBg()
			carefulCyborg.show()
		"Deadly Dino":
			changeBg()
			deadlyDino.show()
		"Fire Fox":
			changeBg()
			fireFox.show()
		"Goldminator (Lython)":
			goldminator.show()
			musicBox.bossTheme()
		"Seaplusplus (Cshark)" :
			seaplusplus.show()
			musicBox.bossTheme()
		"Burnbie (Lavascript)":
			burnbie.show()
			musicBox.bossTheme()
		"Darknight (GoDam)":
			darknight.show()
			musicBox.bossTheme()
		_:
			godog.show()

func setupCharacter():#Display character
	#Hide HP and power bar
	character.find_node("healthBar").hide()
	character.find_node("PowerButton").hide()

func characterAnimation():
	#Witty Witch
	wittyWitch.animation = "attack"	
	#Seaplusplus
	seaplusplus.animation = "attack"

func updateText():#Update text according to character selected
	showCharacter()#Show Character
	selectHeader.set_text(selected)#Set header as text
	match selected:#Set text based on character
		"Witty Witch":#Witty Witch selected
			text.set_text("Unlock: World #9\nPower: Worry Not\n- Sacrifices 1 life for 100 seconds time reduction.")
		"Ticky Troll":
			text.set_text("Unlock: World #10\nPower: Timely Tongue\n- Adds 4 lives but spend additional 2 minutes.")
		"Careful Cyborg":
			text.set_text("Unlock: World #6\nCalculating\n- Reduces time spent by 30 seconds")
		"Swee Soldier":
			text.set_text("Unlock: World #1\nSteel Heart\n- Adds 2 lives")
		"Mister I":
			text.set_text("Unlock: World #2\nMIA\n- Jumps 3 levels")
		"Humble B":
			text.set_text("Unlock: World #3\nHumble Bundle\n- Randomizes question (5 uses)")
		"Rider Rabbit":
			text.set_text("Unlock: World #4\nFast & Steady\n- Slow timer by 1/2 speed for 30 real seconds")
		"Zesty Zombie":
			text.set_text("Unlock: World #5\nMunch Munch\n- Sacrifice 1 life for 5 levels")
		"Deadly Dino":
			text.set_text("Unlock: World #7\nDouble Damage\n- For 15 seconds x2 damage.")
		"Fire Fox":
			text.set_text("Unlock: World #8\nFatal Furry\n- Randomly activates another powers")
		"Godog":
			text.set_text("Default\nNo Powers")
		"Goldminator (Lython)":
			text.set_text("Cannot be unlocked\nSecret boss of Lython. ")
		"Seaplusplus (Cshark)" :
			text.set_text("Cannot be unlocked\nSecret boss of Cshark. ")
		"Burnbie (Lavascript)":
			text.set_text("Cannot be unlocked\nSecret boss of Lavascript. ")
		"Darknight (GoDam)":
			text.set_text("Cannot be unlocked\nSecret boss of GoDam. ")
		_:#Default
			selectHeader.set_text("Select a Character")
			text.set_text("Waiting for character selection. ")

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

#Go back to Lore type selection
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/Others/LoreTypeSelection.tscn")

func _on_GDIcon_pressed():#Selected Godog
	selected = "Godog" 
	updateText()#Update text accordingly

func _on_SSIcon_pressed(): #Selected Swee Soldier
	selected = "Swee Soldier" 
	global.worldSelected = "World #1"#Set to world 1
	updateText()#Update text accordingly

func _on_HBIcon_pressed():#Selected Humble B
	selected = "Humble B" 
	global.worldSelected = "World #3"#Set to world 3
	updateText()#Update text accordingly

func _on_RRIcon_pressed():#Selected Rider Rabbit
	selected = "Rider Rabbit" 
	global.worldSelected = "World #4"#Set to world 4
	updateText()#Update text accordingly

func _on_ZZIcon_pressed():#Selected Zesty Zombie
	selected = "Zesty Zombie" 
	global.worldSelected = "World #5"#Set to world 5
	updateText()#Update text accordingly

func _on_CCIcon_pressed():#Selected Careful Cyborg
	selected = "Careful Cyborg" 
	global.worldSelected = "World #6"#Set to world 6
	updateText()#Update text accordingly

func _on_DDIcon_pressed():#Selected Deadly Dino
	selected = "Deadly Dino" 
	global.worldSelected = "World #7"#Set to world 7
	updateText()#Update text accordingly

func _on_FFIcon_pressed():#Selected Fire Fox
	selected = "Fire Fox" 
	global.worldSelected = "World #8"#Set to world 8
	updateText()#Update text accordingly

func _on_MrIIcon_pressed():#Selected Mister I
	selected = "Mister I" 
	global.worldSelected = "World #2"#Set to world 2
	updateText()#Update text accordingly

func _on_WWIcon_pressed():#Selected Witty Witch
	selected = "Witty Witch" 
	global.worldSelected = "World #9"#Set to world 9
	updateText()#Update text accordingly

func _on_TTIcon_pressed():#Selected Tickly Troll
	selected = "Ticky Troll" 
	global.worldSelected = "World #10"#Set to world 10
	updateText()#Update text accordingly

func _on_LythonIcon_pressed():#Selected Lython
	selected = "Goldminator (Lython)" 
	updateText()#Update text accordingly

func _on_CsharkIcon_pressed():#Selected Cshark
	selected = "Seaplusplus (Cshark)" 
	updateText()#Update text accordingly

func _on_LavascriptIcon_pressed():#Selected Lavascript
	selected = "Burnbie (Lavascript)" 
	updateText()#Update text accordingly

func _on_GoDamIcon_pressed():#Selected GoDam
	selected = "Darknight (GoDam)" 
	updateText()#Update text accordingly
