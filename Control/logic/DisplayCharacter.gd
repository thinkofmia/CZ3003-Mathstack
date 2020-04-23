extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	displayCharacter()

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

func displayCharacter():
	#Hide all sprites
	hideAllSprites()
	#Show character and set character
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
