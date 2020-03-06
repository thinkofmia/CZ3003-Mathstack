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

func jump():
	#move character
	motion.y = JUMP_HEIGHT	
	motion = move_and_slide(motion, UP)

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
			#Gameover
			get_tree().change_scene("res://menus/gameModes/Gameover.tscn")

func addLife():
	if (hearts<5):
		hearts+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#Adds motion at every frame/gravity
	motion.y += GRAVITY
	fixHearts()
	#check if on floor
	if is_on_floor():
		#For debugging
		#print("On floor.")
		#for jumping
		if Input.is_action_just_pressed("ui_up"):
			jump()
		if Input.is_action_just_pressed("ui_down"):
			addLife()
			fixHearts()
	#Set motion to 0,0 if no motion
	motion = move_and_slide(motion, UP)
	if motion.y > 1000:
		get_tree().change_scene("res://menus/gameModes/Gameover.tscn")
	#For debugging
	#print(motion)
	
	#End
	pass
