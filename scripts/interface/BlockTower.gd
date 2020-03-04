extends VBoxContainer

func _physics_process(delta):
	var scene = load("res://menus/util/Block.tscn")
	var block = scene.instance()
	if Input.is_action_just_pressed("ui_down"):
		add_child(block)
		#For debugging
		print("Adding Block")
