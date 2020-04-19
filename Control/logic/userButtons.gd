extends Button

func _on_UserButton_pressed():
	#Display user selected
	print("User Selected: "+get_text())
	#Change Scene
	get_tree().change_scene("res://View/admin/EditTarget.tscn")
