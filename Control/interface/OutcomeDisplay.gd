extends VBoxContainer

func _on_CloseButton_pressed():
	disappear()

func appear():
	var playBoard = get_tree().get_root().get_node("World").find_node("PlayBoard")
	playBoard.show()
	self.visible = true

func disappear():
	var playBoard = get_tree().get_root().get_node("World").find_node("PlayBoard")
	playBoard.hide()
	self.visible = false
	
