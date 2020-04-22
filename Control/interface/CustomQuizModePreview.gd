extends Node

var message

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

func hideButtons():
	$ShareButton.hide()
	$FBButton.hide()
	$WAButton.hide()
	$RedditButton.hide()
	$BackButton.hide()
	$EditButton.hide()
	$DeleteButton.hide()
	$PlayBoard/MarginContainer/VBoxContainer/Button.hide()
	
func showButtons():
	$ShareButton.show()
	$FBButton.show()
	$WAButton.show()
	$RedditButton.show()
	$BackButton.show()
	$PlayBoard/MarginContainer/VBoxContainer/Button.show()


func _ready():
	hideButtons()
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
					continue
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
	showButtons()
	#Set Message
	message = "Hey! Try '"+global.customTitle+"' out by"+global.customCreator+". The Quiz ID is "+global.customID+"!"

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


func _on_ShareButton_pressed():#For Twitter
	var tweet = "https://twitter.com/intent/tweet?text="
	OS.shell_open(tweet+message)

func _on_WAButton_pressed():
	var url = "https://wa.me/?text="
	OS.shell_open(url+message)

func _on_RedditButton_pressed():
	var url = "https://reddit.com/submit?title="
	OS.shell_open(url+message)

func _on_FBButton_pressed():
	var facebook = "http://www.facebook.com/sharer.php?s=100&p[title]=MyHighScore&p[summary]="
	OS.shell_open(facebook+message)

