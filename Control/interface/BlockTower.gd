extends VBoxContainer
const BASEHEIGHT = 320
var noOfBoxes = 1 #Also represents the scores

func _ready():
	noOfBoxes = 1

func getNoOfBoxes():
	return noOfBoxes

func _physics_process(delta):
	var scene = load("res://View/util/Block.tscn")
	#if Input.is_action_just_pressed("ui_down"):
	#	addBlock()
		
	#if Input.is_action_just_pressed("ui_right"):
	#	selfDestruct()

func selfDestruct():
	#Save global vars
	global.highscore = noOfBoxes
	global.time = get_tree().get_root().get_node("World").find_node("Timer").getTime()
	print(global.highscore)
	print(global.time)
	#self destruct
	get_parent().remove_child(self)

func addBlock():
	var scene = load("res://View/util/Block.tscn")
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
	#Add Life per 10 levels
	if (int(noOfBoxes)%10 == 0):
		var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter")
		character.addLife()
		
