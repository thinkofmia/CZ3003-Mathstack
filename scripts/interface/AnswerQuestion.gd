extends Button
var answer = true


# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_text()=="216"):
		answer = true
	else:
		answer = false
	
func _on_AnswerButton_pressed():
	if (answer):#Check if correct answer was click
		print("Correct!")
		
	else:
		print("Wrong!")
	pass
