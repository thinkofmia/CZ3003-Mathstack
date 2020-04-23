extends KinematicBody2D

#Set direction of which is up
const UP = Vector2(0,-1)
#Set gravity
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
# Vector2 holds data of x and y value
var motion = Vector2()

func _ready():#On start display character
	displayCharacter()

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

#Hide all sprites
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
	$TTSprite.hide()
	$WWSprite.hide()
	$healthBar.hide()
	$PowerButton.hide()

func _physics_process(delta):
	#Adds motion at every frame/gravity
	motion.y += GRAVITY
	if is_on_floor():#check if on floor
		#If up button is pressed, jump
		if Input.is_action_just_pressed("ui_up"):
			jump()
	#Every 10 secons
	if (int(global.timeSeconds)%10 == 0):
		#Make character speak
		characterSpeak("I can't wait to get to the top! ")
	#Set motion to 0,0 if no motion
	motion = move_and_slide(motion, UP)

#Jump function
func jump():
	#move character
	motion.y = JUMP_HEIGHT	
	motion = move_and_slide(motion, UP)

#Display character
func displayCharacter():
	#Hide all sprites
	hideAllSprites()
	#Show character based on selection
	match global.characterSelected:
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
		"Witty Witch":
			$WWSprite.show()
		"Ticky Troll":
			$TTSprite.show()
		_:
			$GodotSprite.show()
