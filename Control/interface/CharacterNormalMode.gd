extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	displayCharacter()
	pass # Replace with function body.


func displayCharacter():
	#Hide all sprites
	#Show character and set character
	match global.normalModeCharacterSelected:
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
