extends KinematicBody2D

#Set direction of which is up
const UP = Vector2(0,-1)
#Set gravity
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
# Vector2 holds data of x and y value
var motion = Vector2()
# Shorter than motionx = 0, motiony = 0;
var hearts = 1
#Counter
var counter = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	displayCharacter()
	counter = 5
	#recoverPower
	recoverPower()

func displayCharacter():
	#Hide all sprites
	hideAllSprites()
	#Show character and set character
	match global.characterSelected:
		"Witty Witch":
			$WWSprite.show()
		"Ticky Troll":
			$TTSprite.show()
		"Swee Soldier":
			$SSSprite.show()
		"Mister I":
			$MrISprite.show()
		"Humble B":
			$HBSprite.show()
		"Rider Rabbit":
			$RRSprite.show()
		"Zesty Zombie":
			$ZZSprite.show()
		"Careful Cyborg":
			$CCSprite.show()
		"Deadly Dino":
			$DDSprite.show()
		"Fire Fox":
			$FFSprite.show()
		_:
			$GodotSprite.show()
			$PowerButton.hide()

#Hide Powers
func losePower():
	$PowerButton.hide()

#Recover Powers
func recoverPower():
	if (global.characterSelected != "Godot"):
		$PowerButton.show()
	if (global.characterSelected != "Humble B"):
		counter = 5

#Lose Health
func loseHP():
	hearts -= 1
	fixHearts()

func wwPower():
	#Get Timer
	var timer = get_tree().get_root().get_node("World").find_node("Timer")
	#Reduce global time by 100 seconds by sacricing 1 life
	timer.timer -= 100
	loseHP()
	#Shout
	characterSpeak("Rewinding time! ")

func ccPower():
	#Get Timer
	var timer = get_tree().get_root().get_node("World").find_node("Timer")
	#Reduce global time by 30 seconds
	timer.timer -= 30
	#Shout
	characterSpeak("Re-calculating time... ")

func ffPower():
	var random = int(floor(rand_range(1,5)))
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


func ddPower():
	#Shout
	characterSpeak("Deadly Damage! ")
	#Gives x2 Damage
	global.ddPower = 1
	#Change music and color
	var mainMusic = get_tree().get_root().get_node("World").find_node("MusicBox")
	mainMusic.fastForward()
	var bg = get_tree().get_root().get_node("World").find_node("Texture")
	var header = get_tree().get_root().get_node("World").find_node("RichTextLabel")
	bg.set_self_modulate(Color( 1, 0, 1, 1 )) 
	header.add_color_override("font_color", Color(1,0,0,1))
	$DDSprite.set_self_modulate(Color( 1, 0, 1, 1 )) 
	yield(get_tree().create_timer(15.0), "timeout")
	mainMusic.playTrack()
	$DDSprite.set_self_modulate(Color( 1, 1, 1, 1 )) 
	bg.set_self_modulate(Color( 1, 1, 1, 1 )) 
	header.add_color_override("font_color", Color(1,1,1,1))
	#Return
	global.ddPower = 0

func zzPower():
#Shout
	characterSpeak("*munch munch* ")
	#Sacrifice 1 health for 5 levels
	hearts = hearts - 1
	fixHearts()
	if (hearts>0):
		var qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
		var blkTower = get_tree().get_root().get_node("World").find_node("BlockTower")
		qnMenu.hide()
		#Jump three times
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")
		blkTower.addBlock()
		self.jump()
		yield(get_tree().create_timer(1.0), "timeout")
		#Randomise Qn
		qnMenu.show()
		qnMenu.randomizeQuestion()
	$PowerButton.hide()

func ssPower():
	#Shout
	characterSpeak("Steel Heart! ")
	#Add 4 lives
	addLife()
	addLife()
	addLife()
	addLife()
	$PowerButton.hide()

func MrIPower():
	#Shout
	characterSpeak("MIA! ")
	$PowerButton.hide()
	var qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
	var blkTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	qnMenu.hide()
	#Jump three times
	blkTower.addBlock()
	self.jump()
	yield(get_tree().create_timer(1.0), "timeout")
	blkTower.addBlock()
	self.jump()
	yield(get_tree().create_timer(1.0), "timeout")
	blkTower.addBlock()
	self.jump()
	yield(get_tree().create_timer(1.0), "timeout")
	#Randomise Qn
	qnMenu.show()
	qnMenu.randomizeQuestion()

func rrPower():
	#Shout
	characterSpeak("Fast and steady wins the race. ")
	#Slow time for 30 seconds
	global.rrPower = 0.5
	$PowerButton.hide()
	var mainMusic = get_tree().get_root().get_node("World").find_node("MusicBox")
	mainMusic.fastForward()
	var bg = get_tree().get_root().get_node("World").find_node("Texture")
	var header = get_tree().get_root().get_node("World").find_node("RichTextLabel")
	bg.set_self_modulate(Color( 1, 0, 1, 1 )) 
	header.add_color_override("font_color", Color(1,0,0,1))
	$RRSprite.set_self_modulate(Color( 1, 0, 1, 1 )) 
	yield(get_tree().create_timer(30.0), "timeout")
	mainMusic.playTrack()
	$RRSprite.set_self_modulate(Color( 1, 1, 1, 1 )) 
	bg.set_self_modulate(Color( 1, 1, 1, 1 )) 
	header.add_color_override("font_color", Color(1,1,1,1))
	global.rrPower = 1

func callPower():
	$PowerButton.hide()
	#Play Sound
	var sound = get_tree().get_root().get_node("World").find_node("PowerupSound")
	sound.play()
	
	#Check Character
	match global.characterSelected:
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
		"Humble B":
			#Shout
			characterSpeak("Next question please. ")
			#Randomize Qn. 5 Uses
			var qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
			qnMenu.randomizeQuestion()
			counter -= 1
			if (counter>0):
				$PowerButton.show()
		"Rider Rabbit":
			rrPower()
		"Mister I": #Jump 3 levels
			MrIPower()
		_:
			pass

func hideAllSprites():
	$SSSprite.hide()
	$GodotSprite.hide()
	$MrISprite.hide()
	$PowerButton.hide()
	$HBSprite.hide()
	$RRSprite.hide()
	$ZZSprite.hide()
	$CCSprite.hide()
	$DDSprite.hide()
	$FFSprite.hide()
	$WWSprite.hide()
	$TTSprite.hide()

func jump():
	#move character
	motion.y = JUMP_HEIGHT	
	motion = move_and_slide(motion, UP)

func jump_to_end():
	motion.y = JUMP_HEIGHT
	motion.x = 110
	motion = move_and_slide(motion, Vector2(1, -1))
	

func fixHearts(): #set # of Hearts Displayed
	#set var to healthbar node
	var hpBar = $healthBar
	hpBar.get_node("health2").hide()
	hpBar.get_node("health1").hide()
	hpBar.get_node("health3").hide()
	hpBar.get_node("health4").hide()
	hpBar.get_node("health5").hide()
	match hearts: #Similar to switch-case
		1: #case 1
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
		_: #Default case
			#Character Speaks
			characterSpeak("OH NO! I am falling. :(")
			#Get blkTower
			var blkTower = get_tree().get_root().get_node("World").find_node("BlockTower")
			if is_instance_valid(blkTower): #Check if still exists
				blkTower.selfDestruct()
			#Gameover
			#get_tree().change_scene("res://menus/gameModes/Gameover.tscn")

func addLife():
	if (hearts<5):
		hearts+=1

#Makes character speak
func characterSpeak(content):
	$SpeechBubble.show()
	$SpeechBubble/Speech.set_text(content)
	yield(get_tree().create_timer(2.0), "timeout")
	$SpeechBubble.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#Adds motion at every frame/gravity
	motion.y += GRAVITY
	fixHearts()
	if (int(global.timeSeconds)%10 == 0):
		#Make character speak
		characterSpeak("I can't wait to get to the top! ")
	#Movement
	var blkTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	if Input.is_action_just_pressed("ui_left"):
		if is_instance_valid(blkTower): #Check if Challenge Mode or not
			motion.x -= SPEED
	if Input.is_action_just_pressed("ui_right"):
		if is_instance_valid(blkTower): #Check if Challenge Mode or not
			motion.x += SPEED
	
	#check if on floor
	if is_on_floor():
		#For debugging
		#print("On floor.")
		#for jumping
		if Input.is_action_just_pressed("ui_up"):
			jump()
		#Cheat Code
		if Input.is_action_just_pressed("ui_down"):
			addLife()
			fixHearts()
			var qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
			qnMenu.correctAnswer()
		
	#Set motion to 0,0 if no motion
	motion = move_and_slide(motion, UP)
	if motion.y > 1000:
		get_tree().change_scene("res://View/gameModes/Gameover.tscn")
	#For debugging
	#print(motion)
	
	#End
	pass


func _on_PowerButton_pressed():
	callPower()
