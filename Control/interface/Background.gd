extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#Set bg
func setBackground():
	#Make texture null first
	set_texture(null)
	#Set Texture
	match global.worldSelected:
		"World #1":
			set_texture(preload("res://textures/mountain.png"))
		"World #2":
			set_texture(preload("res://textures/mountainView.jpg"))
		"World #3":
			set_texture(preload("res://textures/BG.png"))
		"World #4":
			set_texture(preload("res://textures/winter.png"))
		"World #5":
			set_texture(preload("res://textures/graveyard.png"))
		"World #6":
			set_texture(preload("res://textures/desert.png"))
		"World #7": #TO BE CHANGED
			set_texture(preload("res://textures/mountain.png"))
		"World #8": #TO BE CHANGED
			set_texture(preload("res://textures/mountainView.jpg"))
		"World #9":#TO BE CHANGED
			set_texture(preload("res://textures/BG.png"))
		"World #10":#TO BE CHANGED
			set_texture(preload("res://textures/winter.png"))
		_:
			set_texture(preload("res://textures/graveyard.png"))
