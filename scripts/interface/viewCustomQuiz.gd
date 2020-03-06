extends Button

#Initialize selected quiz to none
var quizSelected = ""

func _on_CustomQuizButton_pressed():
	#Save selected world into variables
	quizSelected = get_text()
	
	#Debug
	print("Quiz Selected: "+quizSelected)
	
	#Sent user to custom quiz preview
	get_tree().change_scene("res://menus/gameModes/CustomQuizModePreview.tscn")
