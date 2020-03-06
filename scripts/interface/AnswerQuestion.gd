extends Button

#Save file locations as a boolean
export(bool) var answer

# Called when the node enters the scene tree for the first time.
func _ready():
	setOption()
	
func setOption():
	if (get_text()=="216"):
		answer = true
	else:
		answer = false
	
func _on_AnswerButton_pressed():
	if (answer):#Check if correct answer was click
		print("Correct!")
		
		#Add block
		var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
		blockTower.addBlock()
		#Make sprite jump!!
		var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter")
		character.jump()
		
	else:
		print("Wrong!")
		var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter")
		character.hearts -= 1
		character.fixHearts()
	pass
