extends VBoxContainer

func _on_CloseButton_pressed():
	disappear()

func appear():
	self.visible = true

func disappear():
	self.visible = false
