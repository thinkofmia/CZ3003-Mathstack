extends VBoxContainer
var question
var option1
var option2
var option3
var option4
var level
var getQuestions

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

onready var http : HTTPRequest = $HTTPRequest
# Called when the node enters the scene tree for the first time.
func _ready():
	global.worldsVisited = [global.worldSelected] #On start, set world visited to be 1
	option1 = $MarginContainer/row/columnLeft/Option1
	option2 = $MarginContainer/row/columnLeft/Option2
	option3 = $MarginContainer/row/columnRight/Option3
	option4 = $MarginContainer/row/columnRight/Option4
	#Get questions based on codes
	getQuestions=global.difficulty+"World"+global.worldSelected.substr(7,1)
	print(getQuestions)
	#http request to get question based on the selected difficulty and world
	Firebase.get_document("%s" % str(getQuestions), http)
	yield(get_tree().create_timer(1), "timeout")
	question_info = (questions.values())
	#for each questions in the array
	for i in range(0,question_info[0].size()):
		#extract question attribute based on i
		question_display= (question_info[0][i]['fields'])
		qTextArr.append(question_display['QuestionText'].values()[0])
		print(qTextArr)
		op1Arr.append(question_display['Option1'].values()[0])
		op2Arr.append(question_display['Option2'].values()[0])
		op3Arr.append(question_display['Option3'].values()[0])
		op4Arr.append(question_display['Option4'].values()[0])
		ansArr.append(question_display['Ans'].values()[0])
		#exArr.append(question_display['Explanation'].values()[0])
	#choose a random question
	global.highscore = 0
	randomizeQuestion()
	
func randomizeQuestion():
	#Get level
	var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()
		global.highscore = level
		if level >= 100: #Stop at level 100
			blockTower.selfDestruct()
	
	#generate a random number between 0 and number of questions
	var random = int(floor(rand_range(0,question_info[0].size())))
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
	#set question
	question = [op1, op2, op3, op4,ans] 
	#Set Question Label
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()-1
		find_node("QuestionLabel").set_text("Q"+str(level+1)+") "+str(qText)+"?")

func checkLevelTens(): #Check if the player reaches levels of ten
	var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()-1
		global.highscore = level
		#Check if its mod 10
		if (level%10 == 0):
			var NextWorldBoard = get_tree().get_root().get_node("World").find_node("NextWorld")
			#Hides access world
			NextWorldBoard.hideAccessedWorld()
			NextWorldBoard.show()
			NextWorldBoard.find_node("Title").set_text("Level "+str(level)+" complete!")
			self.hide()

func correctAnswer():
	print("Correct!")
	#Play Sound
	var sound = get_tree().get_root().get_node("World").find_node("CorrectSound")
	sound.play()
		
	#Add block
	var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	blockTower.addBlock()
	#Make sprite jump!!
	var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter")
	character.jump()
	#Make Character speak!
	character.characterSpeak("GOOD JOB! ")
	
	if (global.ddPower==1):
		var qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
		qnMenu.hide()
		yield(get_tree().create_timer(1.0), "timeout")
		#Add block
		blockTower.addBlock()
		#Make sprite jump!!
		character.jump()
		qnMenu.show()
	randomizeQuestion()
	checkLevelTens()

func wrongAnswer():
	print("Wrong!")
	#Play Sound
	var sound = get_tree().get_root().get_node("World").find_node("WrongSound")
	sound.play()
		
	var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter")
	character.hearts -= 1
	if (global.ddPower==1):
		character.hearts -= 1
	character.fixHearts()
	if (character.hearts <= 0):
		self.hide()
	#Make Character speak!
	character.characterSpeak("SHUCKS! That was wrong. ")
	randomizeQuestion()
	
func checkAnswer(option):
	if (str(question[4])==option.get_text()):#Check if correct answer was click
		correctAnswer()	
	else:
		wrongAnswer()
	


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


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		#error
		404:
			return
		#success
		200:
			#assign the response to questions
			self.questions = response_body
