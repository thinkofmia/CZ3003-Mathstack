extends Sprite


func _ready():
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://View/teachers/StatisticScene.tscn")



func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")
