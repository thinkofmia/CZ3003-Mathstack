extends Button

func _on_UserButton_pressed():
	#Display user selected
	print("User Selected: "+get_text())
	#store name to global selectUserEdit
	global.selectUserEdit=get_text()
	#Change Scene
	get_tree().change_scene("res://View/admin/EditTarget.tscn")


func _on_UserStatsButton_pressed():
	#Display user selected
	print("User Selected: "+get_text())
	#store name to global selectUserEdit
	global.selectedTarget=get_text()
	#Change Scene
	get_tree().change_scene("res://View/teachers/IndividualStats.tscn")
