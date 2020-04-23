extends VBoxContainer
var question
var option1
var option2
var option3
var option4
var level
var getQuestions

#Pop Up Display
var correctStatus
var wrongStatus

var qTextArr=[]
var op1Arr=[]
var op2Arr=[]
var op3Arr=[]
var op4Arr=[]
var ansArr=[]
var exArr=[]


onready var question_info
onready var questions
onready var question_display
onready var questionId
onready var qText
onready var op1
onready var op2
onready var op3
onready var op4
onready var ans
onready var explanation

onready var http : HTTPRequest = get_parent().get_node("MYHTTPRequest2")

# Called when the node enters the scene tree for the first time.
func _ready():
	option1 = $MarginContainer/row/columnLeft/Option1
	option2 = $MarginContainer/row/columnLeft/Option2
	option3 = $MarginContainer/row/columnRight/Option3
	option4 = $MarginContainer/row/columnRight/Option4
	level = 1
	global.storyScore = 0
	#print(global.difficultySelected)
	#print(global.worldSelected)
	getQuestions=global.difficulty+"World"+global.worldSelected.substr(7,1)
	print(getQuestions)
	#http request to get question based on the selected difficulty and world
	Firebase.get_document("%s" % str(getQuestions), http)
	yield(get_tree().create_timer(2), "timeout")
	question_info = (questions.values())
	#for each questions in the array
	for i in range(0,question_info[0].size()):
		#extract each question attribute and put into their res[ective array based on i
		question_display= (question_info[0][i]['fields'])
		qTextArr.append(question_display['QuestionText'].values()[0])
		print(qTextArr)
		op1Arr.append(question_display['Option1'].values()[0])
		op2Arr.append(question_display['Option2'].values()[0])
		op3Arr.append(question_display['Option3'].values()[0])
		op4Arr.append(question_display['Option4'].values()[0])
		ansArr.append(question_display['Ans'].values()[0])
		
		#Check if explanation exists in database
		if question_display.has('Explanation'):
			exArr.append(question_display['Explanation'].values()[0])
		else:
			exArr.append("It is what it is.")
			
		
	#Set Nodes	
	correctStatus = get_tree().get_root().get_node("World").find_node("CorrectStatus")
	wrongStatus = get_tree().get_root().get_node("World").find_node("WrongStatus")
	#choose a random question
	randomizeQuestion()
	#Performance Test
	if (testPerformance.performanceCheck):
		print("Performance Test: Normal Mode - Play")
		testPerformance.getTimeTaken()
	
var random = 0

func randomizeQuestion():
	#questionId = str("DM-N-02-E-01")
	#questionId = str("1")
	#generate a random number between 0 and number of questions
	random = int(floor(rand_range(0,question_info[0].size())))
	print("a: "+ str(random))
	#extract the question attribute from the array based on random
	qText = qTextArr[random]
	op1 = op1Arr[random]
	op2 = op2Arr[random]
	op3 = op3Arr[random]
	op4 = op4Arr[random]
	#extract the answer
	var k = int(ansArr[random])
	match k:
		1:
			ans=op1Arr[random]
		2: 
			ans=op2Arr[random]
		3:
			ans=op3Arr[random]
		4:
			ans=op4Arr[random]
	#set options
	option1.set_text(str(op1)) 
	option2.set_text(str(op2))
	option3.set_text(str(op3))
	option4.set_text(str(op4))
	#Set QnLabel
	find_node("QuestionLabel").set_text("Q"+str(level)+") "+qText)
	#set question
	question = [op1, op2, op3, op4,ans] 
	level += 1
	print("")
	

func checkAnswer(option):
	global.questionCount = global.questionCount + 1
	print(question)
	if (str(question[4])==option.get_text()):#Check if correct answer was click
		print("Correct!")
		#Update score
		global.storyScore +=1
		var scoreBoard = get_tree().get_root().get_node("World").find_node("Score")
		scoreBoard.set_text("Score: "+str(global.storyScore))
		#Display msg
		#temp fix, idk how
		#temp solution: last question dont show explanation
		print(global.questionCount)
		if global.questionCount != 10:
			correctStatus.appear()
		
		#Set explanation
		correctStatus.setExplanation(exArr[random])
		wrongStatus.setExplanation(exArr[random])
		randomizeQuestion()
		
	else:
		print("Wrong!")
		#Display msg
		if global.questionCount != 10:
			wrongStatus.appear()
		#Set explanation
		correctStatus.setExplanation(exArr[random])
		wrongStatus.setExplanation(exArr[random])
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

func _on_Request_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		#error
		404:
			return
		#success
		200:
			#assign the response to the Question
			self.questions = response_body
			#con()


func _on_MYHTTPRequest2_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		#error
		404:
			return
		#success
		200:
			#assign the response to questions
			self.questions = response_body
			#con()
