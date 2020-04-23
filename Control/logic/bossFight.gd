extends Control

# Declare member variables here. Examples:
onready var boss1 = get_tree().get_root().get_node("World").find_node("BossSprite1") #Yellow Cyborg
onready var boss2 = get_tree().get_root().get_node("World").find_node("BossSprite2") #Blue Rabbit
onready var boss3 = get_tree().get_root().get_node("World").find_node("BossSprite3") #Raging Zombie
onready var boss4 = get_tree().get_root().get_node("World").find_node("BossSprite4") #Dark Knight
onready var bg = get_tree().get_root().get_node("World").find_node("BossBg") #Background

#Timer
onready var timer = get_tree().get_root().get_node("World").find_node("Timer") #Background
onready var countdownDisplay = $BossMenu/HProw/TimerVar #Countdown display node
var countdown #Time left to beat boss

#Buttons
onready var option1 = $BossMenu/MarginContainer/row/columnLeft/Option1/Label
onready var option2 = $BossMenu/MarginContainer/row/columnRight/Option2/Label
onready var option3 = $BossMenu/MarginContainer/row/columnLeft/Option3/Label
onready var option4 = $BossMenu/MarginContainer/row/columnRight/Option4/Label

var question #Question Array
var qnNo #Current question number
var ans #Answer to question
onready var questionTitle = $BossMenu/QuestionLabel #Question title node

onready var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter") #Player Character
onready var blkTower = get_tree().get_root().get_node("World").find_node("BlockTower") #Blk Tower
onready var qnBoard = get_tree().get_root().get_node("World").find_node("PlayBoard") #Qn board
onready var music = get_tree().get_root().get_node("World").find_node("MusicBox") #Music box

onready var bossHP = $BossMenu/HProw/BossHealth #Boss HP

var bossMode = false #Boolean if boss mode

# Called when the node enters the scene tree for the first time.
func _ready():
	hideInterface()

#Hide main interface
func hideInterface():
	bg.hide()
	qnBoard.show()
	hide()

func restoreBoss(): #Recover boss stats
	qnNo = 1
	bossHP.value = 100
	print(str(bossHP.value))

func checkBoss(): #Check which boss is it
	var bossNo
	if (blkTower.getNoOfBoxes()>90):
		bossNo = 4 #Dark Knight
	elif (blkTower.getNoOfBoxes()>70):
		bossNo = 3	 #Burning Zombie
	elif (blkTower.getNoOfBoxes()>50):
		bossNo = 2	#Wavy Rabbit
	else:
		bossNo = 1 #Gold Cyborg
	return bossNo
		
func startBossMode(): #Starts boss fight
	restoreBoss() #Recover boss
	bg.show() #Show background
	qnBoard.hide() #Hide question board
	show() #Show boss interface
	setMap() #Set planet
	timer.pauseTime() #Stop time
	randomizeQuestion() #Randomize questions
	countdown = 60*15 #Set countdown to 15secs
	music.bossTheme() #Play boss theme
	character.losePower() #Character loses powers
	yield(get_tree().create_timer(1.0), "timeout") #timeout 1 sec	
	bossMode = true #Set boolean for boss mode check

func endBossMode(): #Ends boss battle
	hideInterface() #Hides boss interface
	if bossHP.value<=0 : #If defeat boss
		bossDies() #Kill boss
		character.addLife() #Gain 1 life
		character.recoverPower() #Restore power
	else: #If fails to defeat boss
		character.hearts -= 1 #Lose 1 life
		character.fixHearts()
	bossMode = false #Boolean to false for boss mode check
	timer.countTime() #Start counting time
	music.playTrack() #Play normal music
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (bossMode == true) and bossHP.value<=0: #Check if boss is defeated
		endBossMode()#End boss fight
	elif (bossMode == true):
		countdown = int(floor(countdown-delta)) #Update time per second
		updateTime()

func updateTime(): #Update time and show on board
	countdownDisplay.set_text(str(floor(int(countdown/60)))+" secs remaining")
	if countdown ==0: #If reaches 0, end boss battle
		endBossMode()

func bossDies(): #kills boss
	#Set Array of Boss
	var bossArr = [boss1,boss2,boss3,boss4]
	bossArr[checkBoss()-1].hide() #hide the boss from sight

func setMap():#Set the planet background based on boss
	#Hide all planets
	bg.find_node("Map1").hide()
	bg.find_node("Map2").hide()
	bg.find_node("Map3").hide()
	bg.find_node("Map4").hide()
	match checkBoss(): #Display planet based on which boss
		2:
			bg.find_node("Map2").show()
		3:
			bg.find_node("Map3").show()
		4:
			bg.find_node("Map4").show()
		_:
			bg.find_node("Map1").show()

#Randomize questions
func randomizeQuestion():
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
	#Set answer
	match int(floor(rand_range(1,5))):
		1:
			option1.set_text(str(finalAns)) 
		2: 
			option2.set_text(str(finalAns)) 
		3:
			option3.set_text(str(finalAns)) 
		4:
			option4.set_text(str(finalAns)) 
	#Store qn set		
	setQuestion(operand1, operand2, operation)
	#set Question title
	questionTitle.set_text("Q"+str(qnNo)+") "+str(question[0])+str(operationStr)+str(question[1])+"?")
	qnNo+=1 #Increment total qn by 1
	
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

#Make the ans close to actual
func randCloseAns(ans):
	var newAns = ans + int(floor(rand_range(-15,15)))
	return newAns 

#Check Ans
func checkAnswer(option):
	if (str(question[3])==option.get_text()):#Check if correct answer was click
		correctAnswer()
	else:
		wrongAnswer()

func damageBoss(): #Reduces boss health
	bossHP.value -= 15

func correctAnswer(): #If correct ans selected
	print("Correct!")
	#Play Sound
	var sound = get_tree().get_root().get_node("World").find_node("CorrectSound")
	sound.play()
	character.characterSpeak("HIYA!! ")#Make Character speak!
	damageBoss() #minus boss hp
	randomizeQuestion() #randomize qns

func wrongAnswer(): #If wrong ans selected
	print("Wrong!")
	#Play Sound
	var sound = get_tree().get_root().get_node("World").find_node("WrongSound")
	sound.play()
	#Make Character speak!
	character.characterSpeak("SHUCKS! That was wrong. ")
	countdown -= 60 #Decrement countdown as penalty
	randomizeQuestion() #Randomize question

func _on_Option1_pressed(): #Press option 1
	checkAnswer(option1)

func _on_Option3_pressed():#Press option 3
	checkAnswer(option3)

func _on_Option2_pressed():#Press option 2
	checkAnswer(option2)

func _on_Option4_pressed():#Press option 4
	checkAnswer(option4)
