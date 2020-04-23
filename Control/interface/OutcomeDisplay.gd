extends VBoxContainer

#Set playboard node
onready var playBoard = get_tree().get_root().get_node("World").find_node("PlayBoard")
onready var explanationText = $ColorRect/ReasonLabel

func _on_CloseButton_pressed():
	disappear()

#Show popup display
func appear():
	playBoard.show()
	self.visible = true

#Hides pop up display
func disappear():
	playBoard.hide()
	self.visible = false
	
#Set the explanation label of display
func setExplanation(explanation):
	explanationText.set_text(explanation)
