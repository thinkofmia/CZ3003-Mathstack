extends KinematicBody2D

onready var power = $PowerButton #Power button node
onready var hpBar = $healthBar #Health bar node

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
	$GodogSprite.hide()
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
	hpBar.hide()
	power.hide()

func _physics_process(delta):
	#Every 10 secons
	if (int(global.timeSeconds)%10 == 0):
		#Make character speak
		characterSpeak("I can't wait to get to the top! ")

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
			$GodogSprite.show()
