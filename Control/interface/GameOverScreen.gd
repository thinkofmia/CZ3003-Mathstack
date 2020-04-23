extends Node

#Sends the user to the leaderboard scene
func _on_LeaderBoardButton_pressed():
	get_tree().change_scene("res://View/teachers/LeaderboardScene.tscn")
