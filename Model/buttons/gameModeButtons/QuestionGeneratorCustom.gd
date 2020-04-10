extends VBoxContainer
var question
var option1
var option2
var option3
var option4
var no_of_questions_remaining = 3
var questions_left_text

onready var http : HTTPRequest = $HTTPRequest
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
onready var qText
onready var op1
onready var op2
onready var op3
onready var op4
onready var ans
onready var explanation

# Called when the node enters the scene tree for the first time.
func _ready():
	option1 = $MarginContainer/row/columnLeft/Option1
	option2 = $MarginContainer/row/columnLeft/Option2
	option3 = $MarginContainer/row/columnRight/Option3
	option4 = $MarginContainer/row/columnRight/Option4
	print(option1)
	Firebase.get_document("Custom%s"%global.customTitle, http)
	#Firebase.get_document("Custom%s"%"a", http)
	yield(get_tree().create_timer(2), "timeout")
	question_info = (questions.values())
	#for each questions in the array
	for i in range(0,question_info[0].size()):
		#extract question attribute based on i
		question_display= (question_info[0][i]['fields'])
		#qTextArr.append("gg")
		qTextArr.append(question_display['QuestionText'].values()[0])
		print(qTextArr)
		op1Arr.append(question_display['Option1'].values()[0])
		op2Arr.append(question_display['Option2'].values()[0])
		op3Arr.append(question_display['Option3'].values()[0])
		op4Arr.append(question_display['Option4'].values()[0])
		ansArr.append(question_display['Ans'].values()[0])
		#exArr.append(question_display['Explanation'].values()[0])
	randomizeQuestion()
	questions_left_text = get_tree().get_root().get_node("World").get_node("GUI").get_node("QnRemainBoard").get_node("NumOfQns")
	questions_left_text.set_text(str(no_of_questions_remaining))
	
#Sets question and store it
func setQuestion(option1, option2, option3, option4,ans):
	#Save question set
	question = [option1, option2, option3, option4,ans] 
	print(question)
	
func randomizeQuestion():
	#questionId = str("DM-N-02-E-01")
	#questionId = str("1")
	#Get level
	var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()
		global.highscore = level
		if level >= 100: #Stop at level 100
			blockTower.selfDestruct()
			
	var random = int(floor(rand_range(0,question_info[0].size())))
	print("a: "+ str(random))
	qText = qTextArr[random]
	op1 = op1Arr[random]
	op2 = op2Arr[random]
	op3 = op3Arr[random]
	op4 = op4Arr[random]
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
	option1.set_text(str(op1)) 
	option2.set_text(str(op2))
	option3.set_text(str(op3))
	option4.set_text(str(op4))
	#Set Question Label
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()
		find_node("QuestionLabel").set_text("Q"+str(level)+") "+qText+"?")

	question = [op1, op2, op3, op4,ans] 
	#level += 1
	print("")
	
	
func randCloseAns(ans):
	var newAns = ans + int(floor(rand_range(-15,15)))
	return newAns 

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
	
	var top_platform = get_tree().get_root().get_node("World").find_node("FinishPlatform")

	if no_of_questions_remaining > 3:
		top_platform.shift()
	
	no_of_questions_remaining -= 1
	questions_left_text.set_text(str(no_of_questions_remaining))
	
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
	
	if no_of_questions_remaining == 0:
		#var timer = get_tree().get_root().get_node("World").get_node("GUI").get_node("Timer")
		#timer.stop()
		hide()
		var completedText = get_tree().get_root().get_node("World").get_node("GUI").get_node("PlayBoard").get_node("CompleteQuiz")
		completedText.show()
		var quitButton = get_tree().get_root().get_node("World").get_node("GUI").get_node("QuitButton")
		quitButton.hide()
		yield(get_tree().create_timer(1.0), "timeout")
		character.jump_to_end()
		character.characterSpeak("Hooray!")

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


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
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
