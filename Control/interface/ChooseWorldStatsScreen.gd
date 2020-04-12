extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	global.statWorldSelected = 1
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")


func _on_Button2_pressed():
	global.statWorldSelected = 2
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")



func _on_Button3_pressed():
	global.statWorldSelected = 3
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")


func _on_Button4_pressed():
	global.statWorldSelected = 4
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")



func _on_Button5_pressed():
	global.statWorldSelected = 5
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")



func _on_Button6_pressed():
	global.statWorldSelected = 6
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")



func _on_Button7_pressed():
	global.statWorldSelected = 7
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")



func _on_Button8_pressed():
	global.statWorldSelected = 8
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")



func _on_Button9_pressed():
	global.statWorldSelected = 9
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")

