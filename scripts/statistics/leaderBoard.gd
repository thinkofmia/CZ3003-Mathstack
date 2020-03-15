extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,10):
		$TextureRect/MarginContainer/MarginContainer/VBoxContainer/ItemList.add_item("  Swee Sen " + "                           " + "80" + "                            " + "20.01" + "                  " + "Swee Soldier")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://menus/Screens_Randy/MainMenu.tscn")
