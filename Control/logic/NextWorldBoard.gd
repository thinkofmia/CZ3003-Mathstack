extends VBoxContainer
var world1
var world2
var world3
var world4
var world5
var world6
var world7
var world8
var world9
var world10
var qnMenu
var bg
var world

# Called when the node enters the scene tree for the first time.
func _ready():
	world1 = find_node("WorldButton")
	world2 = find_node("WorldButton2")
	world3 = find_node("WorldButton3")
	world4 = find_node("WorldButton4")
	world5 = find_node("WorldButton5")
	world6 = find_node("WorldButton6")
	world7 = find_node("WorldButton7")
	world8 = find_node("WorldButton8")
	world9 = find_node("WorldButton9")
	world10 = find_node("WorldButton10")
	qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
	bg = get_tree().get_root().get_node("World").find_node("Background")
	world = global.worldSelected
	changeBg(global.worldSelected)

func changeBg(world):
	match world:
		"World #1":
			bg.set_texture(preload("res://textures/mountain.png"))
		"World #2":
			bg.set_texture(preload("res://textures/mountainView.jpg"))
		_:
			bg.set_texture(preload("res://textures/BG.png"))

func selectWorld(node):
	global.worldSelected = node.get_text()
	print("World Selected: "+global.worldSelected)
	changeBg(global.worldSelected)
	qnMenu.show()
	self.hide()

func _on_WorldButton_pressed(): #World 1 clicked
	selectWorld(world1)

func _on_WorldButton2_pressed():#World 2 clicked
	selectWorld(world2)

func _on_WorldButton3_pressed():#World 3 clicked
	selectWorld(world3)

func _on_WorldButton4_pressed():#World 4 clicked
	selectWorld(world4)

func _on_WorldButton5_pressed():#World 5 clicked
	selectWorld(world5)

func _on_WorldButton6_pressed():#World 6 clicked
	selectWorld(world6)

func _on_WorldButton7_pressed():#World 7 clicked
	selectWorld(world7)

func _on_WorldButton8_pressed():#World 8 clicked
	selectWorld(world8)

func _on_WorldButton9_pressed():#World 9 clicked
	selectWorld(world9)

func _on_WorldButton10_pressed():#World 10 clicked
	selectWorld(world10)
