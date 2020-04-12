extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/WorldName.set_text(global.worldSelected)
	
	#add list of question titles in world to vboxcontainer
	#on question title button pressed, 	get_tree().change_scene("res://View/teachers/EditQnsQDetails.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/EditQnsSelectWorld.tscn")
