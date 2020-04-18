extends KinematicBody2D

const UP = Vector2(0,-1)
const SHIFT_HEIGHT = -500
var motion = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion = move_and_slide(motion, UP)
	if motion.y < 0:
		motion.y += 26
	if motion.y > 0:
		motion.y = 0
		

func shift():
	motion.y = SHIFT_HEIGHT	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
