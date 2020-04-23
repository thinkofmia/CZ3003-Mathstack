extends Node

var message #Message to be put in social sharing

#Firebase var
onready var http : HTTPRequest = $HTTPRequest
onready var quizzes = []
var quiz_info = []
var quiz_display
var getByTitle = false
var getById = false
var delete = false

#Quiz Info var
var Quiz := {
	"Creator":{},
	"Date":{},
	"Id":{},
	"NumQns":{},
	"World":{}
}

#External Nodes vars
onready var tShare = $ShareButton #Twitter Share Node
onready var fbShare = $FBButton #FaceBook Share Node
onready var waShare = $WAButton #WhatsApp Share Node
onready var rShare = $RedditButton #Reddit share node
onready var backButton = $BackButton #Back Button
onready var editButton = $EditButton #Edit Button
onready var deleteButton = $DeleteButton #Delete Button
onready var playButton = $PlayBoard/MarginContainer/VBoxContainer/Button #Play Button

#Interface
onready var customTitle = $PlayBoard/MarginContainer/VBoxContainer/QuizName #Custom Title Node
onready var customCreator = $PlayBoard/MarginContainer/VBoxContainer/AuthorRow/AuthorName #Custom Creator Node
onready var customDate = $PlayBoard/MarginContainer/VBoxContainer/CreationDateRow/CreationDate #Custom Date Node
onready var customNo = $PlayBoard/MarginContainer/VBoxContainer/NumberQnsRow/NumberOfQns #Total number of qns Node
onready var customWorld = $PlayBoard/MarginContainer/VBoxContainer/WorldsRow/Worlds #Custom World Node
onready var customID = $PlayBoard/MarginContainer/VBoxContainer/IdRow/Id #Custom ID Node

#Hide all the buttons
func hideButtons():
	tShare.hide()
	fbShare.hide()
	waShare.hide()
	rShare.hide()
	backButton.hide()
	editButton.hide()
	deleteButton.hide()
	playButton.hide()

#Show default buttons
func showButtons():
	tShare.show()
	fbShare.show()
	waShare.show()
	rShare.show()
	backButton.show()

#On Load
func _ready():
	hideButtons() #Hide All buttons
	if global.customTitle!="": #Check if search/accessed by title
		getByTitle = true
		#http request to get custom quiz details
		Firebase.get_document("CustomQuiz/%s"%global.customTitle, http)
		yield(get_tree().create_timer(2), "timeout") #Timeout 2sec
	else: #If accessed by id
		getById = true
		#http request to get all custom quiz
		Firebase.get_document("CustomQuiz/", http)
		yield(get_tree().create_timer(5), "timeout")#timeout 5sec
		#get values from custom quiz array and put into quiz_info
		quiz_info = (quizzes.values())
		#for each quiz in the array
		for i in range(0,quiz_info[0].size()):
				#extract quiz attribute based on i
				quiz_display= (quiz_info[0][i]['fields'])
				#check if the quiz id contains the search string
				if  str(quiz_display['Id'].values()[0]).findn(global.customID,0) != -1:
					#set quiz values
					global.customTitle = str(quiz_display['QuizName'].values()[0])
					global.customCreator = str(quiz_display['Creator'].values()[0])
					global.customDate = str(quiz_display['Date'].values()[0])
					global.customTotalQn = str(quiz_display['NumQns'].values()[0])
					global.customWorlds = str(quiz_display['World'].values()[0])
					global.customID = str(quiz_display['Id'].values()[0])
					playButton.show() #Show play button if valid quiz
					continue
	#Update interface with text
	customTitle.set_text(global.customTitle)
	customCreator.set_text(global.customCreator)
	customDate.set_text(global.customDate)
	customNo.set_text(global.customTotalQn)
	customWorld.set_text(global.customWorlds)
	customID.set_text(global.customID)
	#Check if player is owner of quiz
	if (global.customCreator == global.username):#If so, allow them to edit or delete quiz
		editButton.show()
		deleteButton.show()
	else:
		editButton.hide()
		deleteButton.hide()
	showButtons()#Show rest of the buttons
	#Set Message for social sharing
	message = "Hey! Try '"+global.customTitle+"' out by"+global.customCreator+". The Quiz ID is "+global.customID+"!"

#Starts playing
func _on_Button_pressed():
	get_tree().change_scene("res://View/gameModes/CustomPlayScreen.tscn")

#Returns back to selection menu
func _on_BackButton_pressed():#Back button pressed
	if (global.modeSelected == "My Custom"):#If my custom mode
		get_tree().change_scene("res://View/gameModes/CustomModeMyQuizzes.tscn")
	else:#Else if All custom
		get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")

#Goes to edit quiz scene
func _on_EditButton_pressed():
	get_tree().change_scene("res://View/gameModes/CustomModeEdit.tscn")

#Firebase
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
			$PlayBoard/MarginContainer/VBoxContainer/Button.show()
			getByTitle = false
		if getById:
			var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
			self.quizzes = response_body
			getById = false
		if delete:
			delete = false
			return 

#Deletes the custom quiz
func _on_DeleteButton_pressed():
	##Firebase access
	Firebase.delete_document("CustomQuiz/%s"%global.customTitle,http)
	hideButtons() #Hide all buttons
	customTitle.set_text("Deleting... ") #Show deletion msg
	yield(get_tree().create_timer(2), "timeout") #Timeout 2 sec
	_on_BackButton_pressed()#Return to quiz list

#Share via twitter
func _on_ShareButton_pressed():
	var tweet = "https://twitter.com/intent/tweet?text="
	OS.shell_open(tweet+message)

#Share via whatsapp
func _on_WAButton_pressed():
	var url = "https://wa.me/?text="
	OS.shell_open(url+message)

#Share via reddit
func _on_RedditButton_pressed():
	var url = "https://reddit.com/submit?title="
	OS.shell_open(url+message)

#Share via facebook
func _on_FBButton_pressed():
	var facebook = "http://www.facebook.com/sharer.php?u=ntulearn.ntu.edu.sg&t=PlayThisQuiz&ps=100&p[title]=&p[summary]="
	OS.shell_open(facebook+message)
