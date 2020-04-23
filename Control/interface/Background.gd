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
		"World #7": 
			set_texture(preload("res://textures/street.png"))
		"World #8": 
			set_texture(preload("res://textures/night.png"))
		"World #9":#TO BE CHANGED
			set_texture(preload("res://textures/bulkhead.png"))
		"World #10":#TO BE CHANGED
			set_texture(preload("res://textures/hazy.png"))
		_:
			set_texture(preload("res://textures/graveyard.png"))
