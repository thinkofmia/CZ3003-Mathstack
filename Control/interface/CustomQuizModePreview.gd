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

