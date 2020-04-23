extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")


func _on_ChooseByClass_pressed():
	get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")


func _on_ChooseByIndividual_pressed(): #View Statistics based on individual
	get_tree().change_scene("res://View/teachers/ViewStudent.tscn")

func _on_ChooseByOverall_pressed():
	global.viewingOverallStats = true
	get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")
