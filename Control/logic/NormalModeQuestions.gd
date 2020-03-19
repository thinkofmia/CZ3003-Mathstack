extends VBoxContainer
var question
var option1
var option2
var option3
var option4
var level

onready var questionId
onready var qText
onready var op1
onready var op2
onready var op3
onready var op4
onready var ans

onready var http : HTTPRequest = $HTTPRequest

var Question := {
	"questionText":{},
	"Option1":{},
	"Option2":{},
	"Option3":{},
	"Option4":{},
	"ans":{}
} setget set_question

# Called when the node enters the scene tree for the first time.
func _ready():
	option1 = $row/columnLeft/Option1
	option2 = $row/columnLeft/Option2
	option3 = $row/columnRight/Option3
	option4 = $row/columnRight/Option4
	level = 0
	global.storyScore = 0
	randomizeQuestion()

#Sets question and store it
func setQuestion(option1, option2, option3, option4):
	var correctAnswer = ans
	#Save question set
	question = [option1, option2, option3, option4,correctAnswer] 
	print(question)
	
	
func con():
	var operationStr = ""
	#Set options
	option1.set_text(str(op1)) 
	option2.set_text(str(op2))
	option3.set_text(str(op3))
	option4.set_text(str(op4))
	setQuestion(option1, option2, option3, option4)
	
	#Set QnLabel
	find_node("QuestionLabel").set_text("Q"+str(level)+") "+qText)
	
func randomizeQuestion():
	questionId = str("DM-N-04-E-01")
	Firebase.get_document("NormalWorld1/%s" % str(questionId), http)
	level += 1
	


func checkAnswer(option):
	global.questionCount = global.questionCount + 1
	if (str(question[4])==option.get_text()):#Check if correct answer was click
		print("Correct!")
		#Update score
		global.storyScore +=1
		var scoreBoard = get_tree().get_root().get_node("World").find_node("Score")
		scoreBoard.set_text("Score: "+str(global.storyScore))
		#Display msg
		var outcome = get_tree().get_root().get_node("World").find_node("CorrectStatus")
		outcome.appear()
		
	else:
		print("Wrong!")
		#Display msg
		var outcome = get_tree().get_root().get_node("World").find_node("WrongStatus")
		outcome.appear()
		
	pass
	randomizeQuestion()


func _on_Option1_pressed():
	checkAnswer(option1)
	pass # Replace with function body.


func _on_Option4_pressed():
	checkAnswer(option4)
	pass # Replace with function body.


func _on_Option3_pressed():
	checkAnswer(option3)
	pass # Replace with function body.


func _on_Option2_pressed():
	checkAnswer(option2)
	pass # Replace with function body.


func set_question (value: Dictionary) -> void:
	Question  = value
	qText = str(Question.QuestionText.stringValue)
	op1 = str(Question.Option1.stringValue)
	op2 = str(Question.Option2.stringValue)
	op3 = str(Question.Option3.stringValue)
	op4 = str(Question.Option4.stringValue)
	ans= str(Question.Ans.stringValue)


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		#error
		404:
			return
		#success
		200:
			self.Question = result_body.fields
			print(result_body.fields)
			con()
