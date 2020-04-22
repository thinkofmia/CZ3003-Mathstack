extends Button

func _on_editQnButton_pressed():
	#Display user selected
	print("Qn Selected: "+get_text())
	#store name to global selectUserEdit
	global.selectQn=get_text()
	#Change Scene
	get_tree().change_scene("res://View/teachers/EditQnsQDetails.tscn")
