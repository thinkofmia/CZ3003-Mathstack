extends VBoxContainer
var question
var option1
var option2
var option3
var option4
var level
var getQuestions
#New Vars
var getEasyQns
var getNormalQns
var getHardQns

#Character
onready var userCharacter = get_tree().get_root().get_node("World").find_node("SelectedCharacter")

#For Primary
var qTextArr=[]
var op1Arr=[]
var op2Arr=[]
var op3Arr=[]
var op4Arr=[]
var ansArr=[]
var totalNoEasyQns = 0

#For Intermediate
var qTextArr2=[]
var op1Arr2=[]
var op2Arr2=[]
var op3Arr2=[]
var op4Arr2=[]
var ansArr2=[]
var totalNoIntQns = 0

#For Advanced
var qTextArr3=[]
var op1Arr3=[]
var op2Arr3=[]
var op3Arr3=[]
var op4Arr3=[]
var ansArr3=[]
var totalNoAdvQns = 0

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
	#Play Scene
	global.worldsVisited = [global.worldSelected] #On start, set world visited to be 1
	option1 = $MarginContainer/row/columnLeft/Option1
	option2 = $MarginContainer/row/columnLeft/Option2
	option3 = $MarginContainer/row/columnRight/Option3
	option4 = $MarginContainer/row/columnRight/Option4
	setQns()
	global.highscore = 0 #Reset Highscore
	
func setQns(): #Set new set of Qns
	#Hide Qn display
	var qnMenu = get_tree().get_root().get_node("World").find_node("QuestionMenu")
	qnMenu.hide()
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	#global.difficulty = "Primary" #Set difficulty to primary
	#Get questions based on codes
	getQuestions="ChallengeWorld"+global.worldSelected.substr(7,1)
	#print(getQuestions)
	#http request to get Primary Qns
	Firebase.get_document("%s" % str(getQuestions), http)
	yield(get_tree().create_timer(3), "timeout")
	#get values from question array and put into question_info
	question_info = (questions.values())
	#print(question_info)
	#for each questions in the array
	resetQnArray()#Reset qn Array
	
	for i in range(0,question_info[0].size()):
		#extract question attribute based on i
		question_display= (question_info[0][i]['fields'])
		#Get Qn ID
		#print(question_info[0][i]['name'])
		var qnDetails
		if global.worldSelected == "World #10": #Find qn difficulty
			qnDetails = question_info[0][i]['name'][81]
		else:
			qnDetails = question_info[0][i]['name'][80]
		print (qnDetails)#Print out qn difficulty
		if qnDetails == "E":
			totalNoEasyQns+=1
			qTextArr.append(question_display['QuestionText'].values()[0])
			op1Arr.append(question_display['Option1'].values()[0])
			op2Arr.append(question_display['Option2'].values()[0])
			op3Arr.append(question_display['Option3'].values()[0])
			op4Arr.append(question_display['Option4'].values()[0])
			ansArr.append(question_display['Ans'].values()[0])
		elif qnDetails == "I":
			totalNoIntQns +=1
			qTextArr2.append(question_display['QuestionText'].values()[0])
			op1Arr2.append(question_display['Option1'].values()[0])
			op2Arr2.append(question_display['Option2'].values()[0])
			op3Arr2.append(question_display['Option3'].values()[0])
			op4Arr2.append(question_display['Option4'].values()[0])
			ansArr2.append(question_display['Ans'].values()[0])
		else:
			totalNoAdvQns +=1
			qTextArr3.append(question_display['QuestionText'].values()[0])
			op1Arr3.append(question_display['Option1'].values()[0])
			op2Arr3.append(question_display['Option2'].values()[0])
			op3Arr3.append(question_display['Option3'].values()[0])
			op4Arr3.append(question_display['Option4'].values()[0])
			ansArr3.append(question_display['Ans'].values()[0])
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
	show()
	
	#Debug purpose
	print("Easy qns = "+str(qTextArr))
	print("Intermediate qns = "+str(qTextArr2))
	print("Advanced qns = "+str(qTextArr3))
	randomizeQuestion() #choose a random question
	
	#Show display
	qnMenu.show()
	#Performance Test
	if (testPerformance.performanceCheck):
		print("Performance Test: Challenge Mode Load Questions")
		testPerformance.getTimeTaken()

func resetQnArray(): #Resets the qn Array
		#Primary Difficulty
		qTextArr = []
		op1Arr = []
		op2Arr = []
		op3Arr = []
		op4Arr = []
		ansArr = []
		totalNoEasyQns = 0
		
		#Intermediate
		qTextArr2 = []
		op1Arr2 = []
		op2Arr2 = []
		op3Arr2 = []
		op4Arr2 = []
		ansArr2 = []
		totalNoIntQns = 0
		
		#Advanced
		qTextArr3 = []
		op1Arr3 = []
		op2Arr3 = []
		op3Arr3 = []
		op4Arr3 = []
		ansArr3 = []
		totalNoAdvQns = 0

func randomizeQuestion():
	#Get level
	var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()-1
		global.highscore = level
		if level >= 100: #Stop at level 100
			blockTower.selfDestruct()
		#Set qn difficulty
		var qnDifficulty
		if (level%10 <5): #If first 5 qns, set difficulty to primary
			qnDifficulty = "Primary"
		elif (level%10<8):
			qnDifficulty = "Intermediate"
		else:
			qnDifficulty = "Advanced" 
		var random #generate a random number between 0 and number of questions
		match qnDifficulty:
			"Advanced":
				print("Displaying Advanced qn...")
				random = int(floor(rand_range(0,totalNoAdvQns)))
				print("a: "+ str(random))
				#extract the question attribute from the array based on random
				qText = qTextArr3[random]
				op1 = op1Arr3[random]
				op2 = op2Arr3[random]
				op3 = op3Arr3[random]
				op4 = op4Arr3[random]
				#extract the answer
				var k = int(ansArr3[random])
				match k:
					1:
						ans=op1Arr3[random]
					2: 
						ans=op2Arr3[random]
					3:
						ans=op3Arr3[random]
					4:
						ans=op4Arr3[random]
			"Intermediate":
				print("Displaying Intermediate qns...")
				random = int(floor(rand_range(0,totalNoIntQns)))
				print("a: "+ str(random))
				#extract the question attribute from the array based on random
				qText = qTextArr2[random]
				op1 = op1Arr2[random]
				op2 = op2Arr2[random]
				op3 = op3Arr2[random]
				op4 = op4Arr2[random]
				#extract the answer
				var k = int(ansArr2[random])
				match k:
					1:
						ans=op1Arr2[random]
					2: 
						ans=op2Arr2[random]
					3:
						ans=op3Arr2[random]
					4:
						ans=op4Arr2[random]
			"Primary":
				print("Displaying Primary qns...")
				random = int(floor(rand_range(0,totalNoEasyQns)))
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
			userCharacter.addLife()
		if (level%25==0) and level!=0 :
			var bossMode = get_tree().get_root().get_node("World").find_node("BossBoard")
			bossMode.startBossMode()

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
