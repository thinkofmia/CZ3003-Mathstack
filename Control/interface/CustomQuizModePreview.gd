extends Node


onready var http : HTTPRequest = $HTTPRequest
var Quiz := {
	"Creator":{},
	"Date":{},
	"Id":{},
	"NumQns":{},
	"World":{}
}

onready var quizzes = []
var quiz_info = []
var quiz_display

var getByTitle = false
var getById = false
var delete = false
func _ready():
	if global.customTitle!="":
		getByTitle = true
		Firebase.get_document("CustomQuiz/%s"%global.customTitle, http)
		yield(get_tree().create_timer(2), "timeout")
	else:
		getById = true
		Firebase.get_document("CustomQuiz/", http)
		yield(get_tree().create_timer(5), "timeout")
		quiz_info = (quizzes.values())
		#for each questions in the array
		for i in range(0,quiz_info[0].size()):
				#extract question attribute based on i
				quiz_display= (quiz_info[0][i]['fields'])
				if  str(quiz_display['Id'].values()[0]).findn(global.customID,0) != -1:
					global.customTitle = str(quiz_display['QuizName'].values()[0])
					global.customCreator = str(quiz_display['Creator'].values()[0])
					global.customDate = str(quiz_display['Date'].values()[0])
					global.customTotalQn = str(quiz_display['NumQns'].values()[0])
					global.customWorlds = str(quiz_display['World'].values()[0])
					global.customID = str(quiz_display['Id'].values()[0])
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
	
	if response_code == 200:
		if getByTitle:
			var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
			self.Quiz = response_body.fields
			#set global attributes
			global.customCreator = str(Quiz.Creator.stringValue)
			global.customDate = str(Quiz.Date.stringValue)
			global.customTotalQn = str(Quiz.NumQns.stringValue)
			global.customWorlds = str(Quiz.World.stringValue)
			global.customID = str(Quiz.Id.stringValue)
			getByTitle = false
		if getById:
			var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
			self.quizzes = response_body
			getById = false
		if delete:
			delete = false
			return 


func _on_DeleteButton_pressed():
	##Fire base delete here
	Firebase.delete_document("CustomQuiz/%s"%global.customTitle,http)
	yield(get_tree().create_timer(2), "timeout")
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
