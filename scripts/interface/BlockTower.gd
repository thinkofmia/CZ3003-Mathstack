extends VBoxContainer
const BASEHEIGHT = 320
var noOfBoxes = 1

func _ready():
	noOfBoxes = 1

func _physics_process(delta):
	var scene = load("res://menus/util/Block.tscn")
	var block = scene.instance()
	if Input.is_action_just_pressed("ui_down"):
		#Set Box position when button press = down
		var boxPos = -85 * noOfBoxes + BASEHEIGHT 
		block.set_position(Vector2(0,boxPos))
		#Spawns a box
		add_child(block)
		#Increment box number
		noOfBoxes+=1
