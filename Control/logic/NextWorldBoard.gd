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
var musicBox

# Called when the node enters the scene tree for the first time.
func _ready():
	hideAccessedWorld()
	#Set World Buttons
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
	#Find Music Box
	musicBox = get_tree().get_root().get_node("World").find_node("MusicBox")
	#Set Qn Menus and bg
	qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
	bg = get_tree().get_root().get_node("World").find_node("Background")
	world = global.worldSelected
	#Timeout
	yield(get_tree().create_timer(1.0), "timeout")
	changeBg(global.worldSelected)
	#Add world selected to list
	global.worldsVisited = [global.worldSelected]
	print(global.worldsVisited)
	#Hide worlds that are already chosen
	hideAccessedWorld()

func changeBg(world):
	#Set bg
	match world:
		"World #1":
			bg.set_texture(preload("res://textures/mountain.png"))
		"World #2":
			bg.set_texture(preload("res://textures/mountainView.jpg"))
		"World #3":
			bg.set_texture(preload("res://textures/BG.png"))
		"World #4":
			bg.set_texture(preload("res://textures/winter.png"))
		"World #5":
			bg.set_texture(preload("res://textures/graveyard.png"))
		"World #6":
			bg.set_texture(preload("res://textures/desert.png"))
		"World #7":
			bg.set_texture(preload("res://textures/mountain.png"))
		"World #8":
			bg.set_texture(preload("res://textures/mountainView.jpg"))
		"World #9":
			bg.set_texture(preload("res://textures/BG.png"))
		"World #10":
			bg.set_texture(preload("res://textures/winter.png"))
		_:
			bg.set_texture(preload("res://textures/graveyard.png"))
	#Play music
	musicBox.playTrack()

func selectWorld(node):
	#Hides access world
	hideAccessedWorld()
	#Get text from world selected
	global.worldSelected = node.get_text()
	print("World Selected: "+global.worldSelected)
	changeBg(global.worldSelected)
	qnMenu.show()
	self.hide()
	#Add world chosen to list
	global.worldsVisited.append(global.worldSelected)
	#Set new set of qns
	qnMenu.setQns()

#Hide world choices that are already accessed
func hideAccessedWorld():
	for item in global.worldsVisited:
		match item:
			"World #1":
				$WorldSelectContainer/WorldSelectRow/WorldButton.hide()
			"World #2":
				$WorldSelectContainer/WorldSelectRow/WorldButton2.hide()
			"World #3":
				$WorldSelectContainer/WorldSelectRow/WorldButton3.hide()
			"World #4":
				$WorldSelectContainer/WorldSelectRow/WorldButton4.hide()
			"World #5":
				$WorldSelectContainer/WorldSelectRow/WorldButton5.hide()
			"World #6":
				$WorldSelectContainer/WorldSelectRow/WorldButton6.hide()
			"World #7":
				$WorldSelectContainer/WorldSelectRow/WorldButton7.hide()
			"World #8":
				$WorldSelectContainer/WorldSelectRow/WorldButton8.hide()
			"World #9":
				$WorldSelectContainer/WorldSelectRow/WorldButton9.hide()
			"World #10":
				$WorldSelectContainer/WorldSelectRow/WorldButton10.hide()
			_:
				pass
			
		
	pass

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
