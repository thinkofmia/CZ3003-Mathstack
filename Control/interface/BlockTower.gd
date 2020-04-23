extends VBoxContainer

const BASEHEIGHT = 320 #Constant variable of base height
var noOfBoxes = 1 #Count the number of boxes. Also it is score+1
onready var newBox = load("res://View/util/Block.tscn") #Set new box instance
onready var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter") #Character Node

#Initialization
func _ready():
	noOfBoxes = 1 #Set No of boxes to 1

#Return no of boxes
func getNoOfBoxes():
	return noOfBoxes

#Destory the block tower
func selfDestruct():
	global.highscore = noOfBoxes - 1 #Save number of boxes -1 as highscore
	#Save time
	global.time = get_tree().get_root().get_node("World").find_node("Timer").getTime()
	#For debugging
	print("Gameplay ended. ")
	print("Highscore: "+str(global.highscore))
	print("Time: "+str(global.time))
	#Deletes self
	get_parent().remove_child(self)

#Add a new block
func addBlock():
	#Set new block as instance
	var block = newBox.instance()
	#Set Box position when button press = down
	var boxPos = -85 * noOfBoxes + BASEHEIGHT 
	block.set_position(Vector2(0,boxPos))
	#Increment box number
	noOfBoxes+=1
	#Set box label
	var level = str(noOfBoxes)
	block.get_node("Label").set_text(level)
	#Spawns a box
	add_child(block)
	#Add Life per 10 levels
	if (int(noOfBoxes)-1%10 == 0):
		character.addLife()
