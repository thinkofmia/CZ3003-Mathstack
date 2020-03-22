extends VBoxContainer
var question
var option1
var option2
var option3
var option4

# Called when the node enters the scene tree for the first time.
func _ready():
	option1 = $row/columnLeft/Option1
	option2 = $row/columnLeft/Option2
	option3 = $row/columnRight/Option3
	option4 = $row/columnRight/Option4
	print(option1)
	randomizeQuestion()

#Sets question and store it
func setQuestion(operand1, operand2, operation):
	#0 = operand1, 1 = operand2, 2 = operation, 3 = correct Answer
	var correctAnswer = 0
	match operation:
		1: #default/1
			correctAnswer = int(operand1+operand2)
		2:
			correctAnswer = int(operand1-operand2)
		3:
			correctAnswer = int(operand1*operand2)
		4:
			correctAnswer = int(operand1%operand2)
	
	#Save question set
	question = [operand1,operand2,operation,correctAnswer] 
	print(question)
	
func randomizeQuestion():
	#Get level
	var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()
		global.highscore = level
		if level >= 100: #Stop at level 100
			blockTower.selfDestruct()
	#Randomize operands
	var operand1 = int(floor(rand_range(10,100)))
	var operand2 = int(floor(rand_range(10,100)))
	#Randomize operations
	var operation = int(floor(rand_range(1,5)))
	print(operation)
	#Set answer
	var finalAns = 0
	var operationStr = ""
		#1 = Addition, 2 = Subtraction, 3 = Multiplication, 4 = Mod
	match operation:
		1:
			operationStr = "+"
			finalAns = operand1+operand2
		2: 
			operationStr = "-"
			finalAns = operand1-operand2
		3:
			operationStr = "*"
			finalAns = operand1*operand2
		4:
			operationStr = "%"
			finalAns = operand1%operand2
	#Set options
	
	option1.set_text(str(randCloseAns(finalAns))) 
	option2.set_text(str(randCloseAns(finalAns)))
	option3.set_text(str(randCloseAns(finalAns)))
	option4.set_text(str(randCloseAns(finalAns)))
	
	match int(floor(rand_range(1,5))):
		1:
			option1.set_text(str(finalAns)) 
		2: 
			option2.set_text(str(finalAns)) 
		3:
			option3.set_text(str(finalAns)) 
		4:
			option4.set_text(str(finalAns)) 
			
	setQuestion(operand1, operand2, operation)
	
	#Set Question Label
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()
		find_node("QuestionLabel").set_text("Q"+str(level)+") "+str(question[0])+str(operationStr)+str(question[1])+"?")

func randCloseAns(ans):
	var newAns = ans + int(floor(rand_range(-15,15)))
	return newAns 

func checkLevelTens(): #Check if the player reaches levels of ten
	var blockTower = get_tree().get_root().get_node("World").find_node("BlockTower")
	if is_instance_valid(blockTower):
		var level = blockTower.getNoOfBoxes()
		global.highscore = level
		#Check if its mod 10
		if (level%10 == 0):
			var NextWorldBoard = get_tree().get_root().get_node("World").find_node("NextWorld")
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
	if (str(question[3])==option.get_text()):#Check if correct answer was click
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
