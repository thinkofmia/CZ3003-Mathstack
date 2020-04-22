extends Node


onready var http : HTTPRequest = $HTTPRequest
var Quiz := {
	"Creator":{},
	"Date":{},
	"Id":{},
	"NumQns":{},
	"World":{}
}

func _ready():
	if global.customTitle!="":
		Firebase.get_document("CustomQuiz/%s"%global.customTitle, http)
	else:
		Firebase.get_document("CustomQuiz/%s"%global.customID, http)
	yield(get_tree().create_timer(2), "timeout")
	#Set Texts
	$PlayBoard/MarginContainer/VBoxContainer/QuizName.set_text(global.customTitle)
	$PlayBoard/MarginContainer/VBoxContainer/AuthorRow/AuthorName.set_text(global.customCreator)
	$PlayBoard/MarginContainer/VBoxContainer/CreationDateRow/CreationDate.set_text(global.customDate)
	$PlayBoard/MarginContainer/VBoxContainer/NumberQnsRow/NumberOfQns.set_text(global.customTotalQn)
	$PlayBoard/MarginContainer/VBoxContainer/WorldsRow/Worlds.set_text(global.customWorlds)
	$PlayBoard/MarginContainer/VBoxContainer/IdRow/Id.set_text(global.customID)
	#Check if player is owner of quiz
	if (global.customCreator == global.username):
		$EditButton.show()
		$DeleteButton.show()
	else:
		$EditButton.hide()
		$DeleteButton.hide()
	#Display Play button
	$PlayBoard/MarginContainer/VBoxContainer/Button.show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://View/gameModes/CustomPlayScreen.tscn")


func _on_BackButton_pressed():#Back button pressed
	if (global.modeSelected == "My Custom"):#If my custom mode
		get_tree().change_scene("res://View/gameModes/CustomModeMyQuizzes.tscn")
	else:#Else if All custom
		get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")


func _on_EditButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeEdit.tscn")
	pass # Replace with function body.


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code == 200:
		self.Quiz = response_body.fields
		#set global attributes
		global.customCreator = str(Quiz.Creator.stringValue)
		global.customDate = str(Quiz.Date.stringValue)
		global.customTotalQn = str(Quiz.NumQns.stringValue)
		global.customWorlds = str(Quiz.World.stringValue)
		global.customID = str(Quiz.Id.stringValue)


func _on_DeleteButton_pressed():
	##Fire base delete here
	#
	#
	#Return to quiz list
	 _on_BackButton_pressed()


func _on_ShareButton_pressed():
	#Sharing the following info NEED to link to social media
	print("Sharing "+global.customTitle)
	print(global.customCreator)
	print(global.customDate)
	print(global.customTotalQn)
	print(global.customWorlds)
	print(global.customID)
	
