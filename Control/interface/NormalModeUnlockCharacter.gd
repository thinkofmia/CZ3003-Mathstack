extends Node

var bg

var power = {
	'Godog':'None',
	'Swee Soldier':'Steel Heart: Add 2 lives',
	'Mister I' : 'MIA: Jump 3 levels',
	'Humble B' : 'Humble Bundle: Randomize question (5 uses)',
	'Rider Rabbit' : 'Fast & Steady: Slow timer by 1/2 speed for 30 real seconds',
	'Fire Fox' : 'Fatal Furry: Randomly activates another powers',
	'Zesty Zombie' : 'Munch Munch: Sacrifice 1 life for 5 levels',
	'Deadly Dino' : 'Double Damage: For 15 seconds x2 damage',
	'Careful Cyborg' : 'Calculating: Reduce time spent by 30 seconds',
	'Witty Witch' : 'Worry Not: Sacrifice 1 life for 100 seconds time reduction',
	'Ticky Troll' : 'Timely Tongue: Add 4 lives but spend additional 2 minutes'
}
# Called when the node enters the scene tree for the first time.
func _ready():
	bg = $Background
	changeBg()
	pass # Replace with function body.



#Change Background
func changeBg():
	$Header.text = "Congratulations on unlocking\n" + global.normalModeCharacterSelected + '\nPower - ' + power[global.normalModeCharacterSelected]
	#Set Background
	bg.setBackground()
	changeMaterial()


#Change Box Material
func changeMaterial():
	var material = $Background/ControlBox
	match global.worldSelected:
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



func changeBg2(selectedBg):
	#Hide all bg
	$Background2.hide()
	$Background3.hide()
	$Background4.hide()
	$Background5.hide()
	$Background6.hide()
	match int(selectedBg):
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
		6:
			$Background6.show()
			
func _on_Button_pressed():
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")
