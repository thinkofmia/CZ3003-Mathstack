extends Node

onready var http:HTTPRequest = $HTTPRequest

func _on_NormalModeButton_pressed():
	global.difficulty="Normal"
	$FadeIn.show()
	$FadeIn.fade_in()	



func _on_ChallengeModeButton_pressed():
	global.difficulty="Challenge"
	$FadeIn.show()
	$FadeIn.fade_in()



func _on_CustomModeButton_pressed():
	global.difficulty="Custom"
	$FadeIn.show()
	$FadeIn.fade_in()

func _ready():
	Firebase.get_document("SaveData/" + global.username, http)
	if (global.accountType == "Teacher"): #Hide normal mode if teacher
		$PlayBoard/Menu/Buttons/NormalModeButton.hide()



func goToMainMenu():
	#Condition
	if (global.accountType == "Teacher"|| global.accountType == "Admin"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")


func _on_BackButton_pressed():
	goToMainMenu()


func _on_FadeIn_fade_finished():
	match global.difficulty:
		"Normal":
			get_tree().change_scene("res://View/gameModes/NormalModeSelectWorld.tscn")
		"Challenge":
			get_tree().change_scene("res://View/gameModes/ChallengeModeSelect.tscn")
		"Custom":
			get_tree().change_scene("res://View/gameModes/CustomModeSelect.tscn")		


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		200:
			global.save = result_body.fields
			global.updateUnlockCharsList(result_body.fields)
			
