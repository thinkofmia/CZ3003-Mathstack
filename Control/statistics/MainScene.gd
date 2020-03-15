extends Sprite

func _ready():
	#$TopBoardSprite.position = Vector2(get_viewport_rect().size.x / 2, 100)
	#$TopBoardLabel.set_position(Vector2(get_viewport_rect().size.x / 2, 100))
	#$TopBoardLabel.set_size($TopBoardSprite.get_rect().size)
	#print($TopBoardLabel.get_rect().size,$TopBoardLabel.get_position_in_parent())
	pass



func _on_LeaderboardButton_pressed():
	get_tree().change_scene("res://View/teachers/leaderboardScene.tscn")


func _on_Button_NormalMode_pressed():
	get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")
