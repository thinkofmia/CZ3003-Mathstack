extends VBoxContainer
const BASEHEIGHT = 320
var noOfBoxes = 1 #Also represents the scores

func _ready():
	noOfBoxes = 1

func _physics_process(delta):
	var scene = load("res://menus/util/Block.tscn")
	var block = scene.instance()
	#if Input.is_action_just_pressed("ui_down"):
	#	addBlock()
		
	if Input.is_action_just_pressed("ui_right"):
		get_parent().remove_child(self)

func addBlock():
	var scene = load("res://menus/util/Block.tscn")
	var block = scene.instance()
	#Set Box position when button press = down
	var boxPos = -85 * noOfBoxes + BASEHEIGHT 
	block.set_position(Vector2(0,boxPos))
	#Increment box number
	noOfBoxes+=1
	#Spawns a box
	var level = str(noOfBoxes)
	block.get_node("Label").set_text(level)
	add_child(block)
	if (int(noOfBoxes)%10 == 0):
		var background = get_tree().get_root().get_node("World").find_node("BgBlue")
		background.duplicate()
