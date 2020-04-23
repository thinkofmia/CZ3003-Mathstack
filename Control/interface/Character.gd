extends KinematicBody2D

const UP = Vector2(0,-1) #Set direction of which is up
const GRAVITY = 20 #Set gravity
const SPEED = 200 #Set speed
const JUMP_HEIGHT = -500 #Set Jump Height
var motion = Vector2() # Vector2 holds data of x and y value
var hearts = 1 #Number of life in character

#Set character vars by nodes
onready var wittyWitch = $WWSprite
onready var tickyTroll = $TTSprite
onready var sweeSoldier = $SSSprite
onready var misterI = $MrISprite
onready var humbleB = $HBSprite
onready var riderRabbit = $RRSprite
onready var zestyZombie = $ZZSprite
onready var carefulCyborg = $CCSprite
onready var deadlyDino = $DDSprite
onready var fireFox = $FFSprite
onready var godog = $GodogSprite

#Other interfaces
onready var power = $PowerButton
onready var hpBar = $healthBar

#External Nodes
onready var timer = get_tree().get_root().get_node("World").find_node("Timer") #Timer Node
onready var music = get_tree().get_root().get_node("World").find_node("MusicBox") #Music Node
onready var bg = get_tree().get_root().get_node("World").find_node("Texture") #Background Node
onready var header = get_tree().get_root().get_node("World").find_node("RichTextLabel") #Header Node
onready var qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu") #Question Display Node
onready var blkTower = get_tree().get_root().get_node("World").find_node("BlockTower") #Block Tower Node
onready var powerupSound = get_tree().get_root().get_node("World").find_node("PowerupSound") #Power up Sound Node
onready var quit = get_tree().get_root().get_node("World").find_node("QuitButton") #Quit Button Node

var counter = 5 #Counter for Humble B power

# Called when the node enters the scene tree for the first time.
func _ready():
	displayCharacter() #Display Character
	counter = 5 #Set Humble B power counter to 5
	recoverPower() #recoverPower

#Display character
func displayCharacter():
	hideAllSprites()#Hide all sprites
	#Show character based on selection
	match global.characterSelected:
		"Witty Witch":
			wittyWitch.show()
		"Ticky Troll":
			tickyTroll.show()
		"Swee Soldier":
			sweeSoldier.show()
		"Mister I":
			misterI.show()
		"Humble B":
			humbleB.show()
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
		_:
			godog.show()
			power.hide() #Hide power button if Godog selected

#Hide Powers
func losePower():
	power.hide()

#Recover Powers
func recoverPower():
	if (global.characterSelected != "Godog" && global.characterSelected != "Godot"):
		power.show() #Show power
	else:
		power.hide()
	if (global.characterSelected != "Humble B"):
		counter = 5 #Set counter to 5 for humble B

#Lose Health
func loseHP():
	hearts -= 1 #Decrement Health
	fixHearts() #Update Health

#Witty Witch Power: Reduce global time by 100 seconds by sacrificing 1 life
func wwPower():
	timer.timer -= 100 #Reduce Timer by 100s
	loseHP() #Minus 1 health
	characterSpeak("Rewinding time! ")#Shout

#Careful Cyborg Power: Reduce global time by 30 seconds
func ccPower():
	timer.timer -= 30 #Reduce global time by 30 sec
	characterSpeak("Re-calculating time... ") #Shout

#Fire Fox Power: Randomly calls other abilities
func ffPower():
	var random = int(floor(rand_range(1,5))) #Get random integer
	match random:
		2:
			ccPower()
		3:
			MrIPower()
		4:
			ssPower()
		5:
			ddPower()
		_:
			rrPower()

#Deadly Dino Power: Double Damage - Answering qns get *2 effect
func ddPower():
	characterSpeak("Deadly Damage! ")#Shout
	global.ddPower = 1 #Activates globally: Gives x2 Damage
	music.fastForward() #Change music to Power music
	#Changes color of sprite, background and header
	bg.set_self_modulate(Color( 0, 1, 1, 1 )) 
	header.add_color_override("font_color", Color(0,1,0,1))
	deadlyDino.set_self_modulate(Color( 1, 1, 0, 1 )) 
	yield(get_tree().create_timer(15.0), "timeout") #Set 15 secs timeout
	music.playTrack() #Play normal music
	#Revert Colours of sprite, background and header
	deadlyDino.set_self_modulate(Color( 1, 1, 1, 1 )) 
	bg.set_self_modulate(Color( 1, 1, 1, 1 )) 
	header.add_color_override("font_color", Color(1,1,1,1))
	global.ddPower = 0 #Deactivates power globally

#Zesty Zombie Power: Eat 1 health to jump 5 levels
func zzPower():
	characterSpeak("*munch munch* ") #Shout
	loseHP() #Lose 1 health
	if (hearts>0): #If still alive
		qnMenu.hide() #Hide the question display
		#Jump five times
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout") #Timeout 1s
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")#Timeout 1s
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")#Timeout 1s
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")#Time out 1s
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")#TImeout 1s
		qnMenu.randomizeQuestion()#Randomise Qn
		qnMenu.show() #Open up question display
	power.hide()#Hide power button

#Swee Soldier Power: Gain 2 lives
func ssPower():
	characterSpeak("Steel Heart! ")#Shout
	#Adds 2 lives
	addLife()
	addLife()
	power.hide() #Hide power button

#Mr I Power: Jump three levels
func MrIPower():
	characterSpeak("MIA! ")#Shout
	power.hide() #Hide Power Button
	qnMenu.hide() #Hide question display
	#Jump three times
	blkTower.addBlock()
	self.jump()
	yield(get_tree().create_timer(1.0), "timeout") #Timeout 1s
	blkTower.addBlock()
	self.jump()
	yield(get_tree().create_timer(1.0), "timeout") #Timeout 1s
	blkTower.addBlock()
	self.jump()
	yield(get_tree().create_timer(1.0), "timeout")#Timeout 1s
	qnMenu.randomizeQuestion()#Randomise Qn
	qnMenu.show()#Show question display

#Rider Rabbit Power: Slow time by 0.5 for 30 real seconds
func rrPower():
	characterSpeak("Fast and steady wins the race. ")#Shout
	global.rrPower = 0.5 #Activate power globally
	power.hide() #Hide power button
	music.fastForward() #Play Powerup Music
	#Change colors of header, sprite and bg display
	bg.set_self_modulate(Color( 1, 0, 1, 1 )) 
	header.add_color_override("font_color", Color(1,0,0,1))
	riderRabbit.set_self_modulate(Color( 1, 0, 1, 1 )) 
	yield(get_tree().create_timer(30.0), "timeout") #Timeout 30sec
	music.playTrack() #Resume normal music
	#Restore colors of header, sprite and bg display
	riderRabbit.set_self_modulate(Color( 1, 1, 1, 1 )) 
	bg.set_self_modulate(Color( 1, 1, 1, 1 )) 
	header.add_color_override("font_color", Color(1,1,1,1))
	global.rrPower = 1 #Disable power globally

#Tickly Troll Power: Add 4 lives while increasing timer by 2min
func ttPower():	
	#Add 4 lives
	addLife()
	addLife()
	addLife()
	addLife()
	timer.timer += 120 #Increase timer by 2mins
	
#Humble B Power: Randomize questions (Up to 5 uses)
func HBPower():
	characterSpeak("Next question please. ")#Shout
	qnMenu.randomizeQuestion() #Randomize question
	counter -= 1 #Reduces Counter by 1
	if (counter>0): #If still has counters, show power
		power.show()
		
#Activate Power
func callPower():
	power.hide() #Hide power button
	powerupSound.play() #Play Sound for power activation
	match global.characterSelected:#Activate powers based on character
		"Fire Fox":
			ffPower()
		"Witty Witch":
			wwPower()
		"Careful Cyborg":
			ccPower()
		"Deadly Dino":
			ddPower()
		"Zesty Zombie":
			zzPower()
		"Swee Soldier":
			ssPower()
		"Ticky Troll":
			ttPower()
		"Humble B":
			HBPower()
		"Rider Rabbit":
			rrPower()
		"Mister I":
			MrIPower()
		_:
			pass

#Hide all sprites
func hideAllSprites():
	power.hide()
	sweeSoldier.hide()
	godog.hide()
	misterI.hide()
	humbleB.hide()
	riderRabbit.hide()
	zestyZombie.hide()
	carefulCyborg.hide()
	deadlyDino.hide()
	fireFox.hide()
	wittyWitch.hide()
	tickyTroll.hide()

#Makes character jump
func jump():
	motion.y = JUMP_HEIGHT	
	motion = move_and_slide(motion, UP)
	
#Makes character jump to clouds (Custom Mode)
func jump_to_end():
	motion.y = JUMP_HEIGHT
	motion.x = 110
	motion = move_and_slide(motion, Vector2(1, -1))
	
#Fix hearts display
func fixHearts(): 
	#Hide all health icons
	hpBar.get_node("health2").hide()
	hpBar.get_node("health1").hide()
	hpBar.get_node("health3").hide()
	hpBar.get_node("health4").hide()
	hpBar.get_node("health5").hide()
	match hearts: #Based on life, show number of hearts
		1: 
			hpBar.get_node("health1").show()
		2:
			hpBar.get_node("health1").show()
			hpBar.get_node("health2").show()
		3:
			hpBar.get_node("health1").show()
			hpBar.get_node("health2").show()
			hpBar.get_node("health3").show()
		4:
			hpBar.get_node("health1").show()
			hpBar.get_node("health2").show()
			hpBar.get_node("health3").show()
			hpBar.get_node("health4").show()
		5:
			hpBar.get_node("health1").show()
			hpBar.get_node("health2").show()
			hpBar.get_node("health3").show()
			hpBar.get_node("health4").show()
			hpBar.get_node("health5").show()
		_: #Default case/Out of life
			characterSpeak("OH NO! I am falling. :(") #Character Speaks
			if is_instance_valid(blkTower): #Check if still exists
				qnMenu.hide()
				quit.hide()
				hpBar.hide() #Hide HP Bar
				addLife() #Add life for debug
				blkTower.selfDestruct() #Destroys tower

#Add one health
func addLife():
	if (hearts<5): #Adds health as long as its less than 5
		hearts+=1

#Makes character speak
func characterSpeak(content):
	#Set contents of speech bubble
	$SpeechBubble/Speech.set_text(content)
	#Show speech bubble
	$SpeechBubble.show()
	#Timeout 2 seconds
	yield(get_tree().create_timer(2.0), "timeout")
	#Hide speech bubble
	$SpeechBubble.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += GRAVITY #Adds motion at every frame/gravity
	fixHearts() #Set health display
	if (int(global.timeSeconds)%15 == 0):#Make character speak every 15 second
		characterSpeak("I can't wait to get to the top! ")
	#Left-Right Movement
	if Input.is_action_just_pressed("ui_left"):
		if is_instance_valid(blkTower): #If game mode, then allow movement
			motion.x -= SPEED
	if Input.is_action_just_pressed("ui_right"):
		if is_instance_valid(blkTower): #If game mode, then allow movement
			motion.x += SPEED
	if is_on_floor():#check if on floor
		if Input.is_action_just_pressed("ui_up"): #If clicked up, jump
			jump()
		#Cheat Code: If press down, gain a life
		#if Input.is_action_just_pressed("ui_down"):
		#	addLife()
		#	fixHearts()
	motion = move_and_slide(motion, UP)#Set motion to 0,0 if no motion
	if motion.y > 1000: #If keeps falling, go to gameover
		get_tree().change_scene("res://View/gameModes/Gameover.tscn")

#If activates power button, call power
func _on_PowerButton_pressed():
	callPower()
