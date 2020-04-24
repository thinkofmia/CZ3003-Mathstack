extends Node

#Nodes
onready var material = $Background/ControlBox #Get control box node
onready var bg = $Background #Get background node
onready var musicBox = $MusicBox #Get music box node

#Buttons
onready var w1 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow1/WorldButton1/W1 #World #1 node
onready var w2 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow1/WorldButton2/W2 #World #2 node
onready var w3 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow1/WorldButton3/W3 #World #3 node
onready var w4 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow1/WorldButton4/W4 #World #4 node

onready var w5 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow2/WorldButton5/W5 #World #5 node
onready var w6 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow2/WorldButton6/W6 #World #6 node
onready var w7 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow2/WorldButton7/W7 #World #7 node
onready var w8 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow2/WorldButton8/W8 #World #8 node

onready var w9 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow3/WorldButton9/W9 #World #9 node
onready var w10 = $PlayBoard/ScrollContainer/MusicOptions/MusicRow3/WorldButton10/W10 #World #10 node
onready var bb = $PlayBoard/ScrollContainer/MusicOptions/MusicRow3/BossButton/Boss #Boss node
onready var pu = $PlayBoard/ScrollContainer/MusicOptions/MusicRow3/PowerupButton/PU #Power up node

# Called when the node enters the scene tree for the first time.
func _ready():
	musicBox.stopMusic()#Stop current music
	changeBg()#Change bg accordingly
	yield(get_tree().create_timer(1.0), "timeout")#Timeout 1 s
	musicBox.playTrack()#Play Music

#Change Background
func changeBg():
	bg.setBackground()#Set Background
	changeMaterial()#Change menu box color
	musicBox.playTrack()#Play Music

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

func _on_W1_pressed():
	activateOnly(w1) #Toggled w1
	global.worldSelected = "World #1" #World #1 Selected
	changeBg() #Change bg accordingly

func _on_W2_pressed():
	activateOnly(w2)#Toggled w2
	global.worldSelected = "World #2" #World #2 Selected
	changeBg()#Change bg accordingly

func _on_W3_pressed():
	activateOnly(w3)#Toggled w3
	global.worldSelected = "World #3" #World #3 Selected
	changeBg()#Change bg accordingly

func _on_W4_pressed():
	activateOnly(w4)#Toggled w4
	global.worldSelected = "World #4" #World #4 Selected
	changeBg()#Change bg accordingly

func _on_W5_pressed():
	activateOnly(w5)#Toggled w5
	global.worldSelected = "World #5" #World #5 Selected
	changeBg()#Change bg accordingly

func _on_W6_pressed():
	activateOnly(w6)#Toggled w6
	global.worldSelected = "World #6" #World #6 Selected
	changeBg()#Change bg accordingly

func _on_W7_pressed():
	activateOnly(w7)#Toggled w7
	global.worldSelected = "World #7" #World #7 Selected
	changeBg()#Change bg accordingly

func _on_W8_pressed():
	activateOnly(w8)#Toggled w8
	global.worldSelected = "World #8" #World #8 Selected
	changeBg()#Change bg accordingly

func _on_W9_pressed():
	activateOnly(w9)#Toggled w9
	global.worldSelected = "World #9" #World #9 Selected
	changeBg()#Change bg accordingly

func _on_W10_pressed():
	activateOnly(w10)#Toggled w10
	global.worldSelected = "World #10" #World #10 Selected
	changeBg()#Change bg accordingly

func _on_Boss_pressed():
	activateOnly(bb)#Toggled bb
	musicBox.bossTheme() #Play boss theme

func _on_PU_pressed():
	activateOnly(pu)#Toggled pu
	musicBox.fastForward()#Plays Power up theme

func activateOnly(selected): #Set all buttons toggled to false except the one selected
	if (selected!= w1):
		w1.pressed = false
	if (selected!=w2):
		w2.pressed = false
	if (selected!= w3):
		w3.pressed = false
	if (selected!=w4):
		w4.pressed = false
	if (selected!= w5):
		w5.pressed = false
	if (selected!=w6):
		w6.pressed = false
	if (selected!= w7):
		w7.pressed = false
	if (selected!=w8):
		w8.pressed = false
	if (selected!= w9):
		w9.pressed = false
	if (selected!=w10):
		w10.pressed = false
	if (selected!= bb):
		bb.pressed = false
	if (selected!=pu):
		pu.pressed = false
	selected.pressed = true #Set it as still pressed

#Go back to Lore type selection
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/Others/LoreTypeSelection.tscn")
