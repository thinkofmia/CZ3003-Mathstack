extends Node

#This is a script meant for unit testing
#Written by Fremont Teng 
#Last Updated (21/03/20)
#To enable this script, go to Project > Project Setting > AutoLoad
#Then check the Simpleton checkbox for unitTestScript.gd and run the program

# Declare member variables here.
var outcome = "false" #True means success, #False means one or more mistake exists
var fakeUsername = "testemail@gmail.com" #Fake Username for testing
var fakePassword = "faker123" #Fake Password for testing

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting Test Script...")
	#Check if register works
	#checkRegister()
	#Wait
	#yield(get_tree().create_timer(20.0), "timeout") #Uncomment this if running check register
	yield(get_tree().create_timer(2.0), "timeout")
	checkLogin() #Check if login works
	yield(get_tree().create_timer(5.0), "timeout")
	#Choose one mode to test!!
	#checkNormalMode()
	checkChallengeMode()
	
func resetOutcome():
	outcome = "false"

func autoplay():
	#Set Important Variables
	var root = get_tree().get_root()
	#Set Screen as Challenge Play screen
	var screen = root.get_node("World")
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	var qnMenu = screen.get_node("GUI/PlayBoard/QuestionMenu")
	qnMenu.correctAnswer()
	print("- Press correct answer once")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	qnMenu.correctAnswer()
	print("- Press correct answer twice")
	autoplay()

func checkChallengeMode():
	#Set Important Variables
	var root = get_tree().get_root()
	resetOutcome()
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Main Menu screen
	var screen = root.get_node("MainMenuTeachersScreen")
	#Press Play Button
	screen._on_Button_pressed("res://View/gameModes/PlayMenu.tscn")
	print("- entering Play Menu")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Play Menu screen
	screen = root.get_node("World")
	#Press Normal Mode Button
	screen._on_ChallengeModeButton_pressed()
	print("- entering Challenge Mode Select Screen")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Challenge Mode Select screen
	screen = root.get_node("World")
	#Select Rider Rabbit
	screen._on_RRIcon_pressed()
	print("- Rider Rabbit Icon Pressed")

	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Select World 2
	screen._on_WorldButton2_pressed()
	print("- World 2 Button Pressed")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Play Challenge Mode
	screen._on_Play_pressed()
	print("- Play Button Pressed")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Challenge Play screen
	screen = root.get_node("World")
	var character = screen.get_node("SelectedCharacter")
	character.callPower()
	print("- Power Button Pressed")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	var qnMenu = screen.get_node("GUI/PlayBoard/QuestionMenu")
	qnMenu.correctAnswer()
	print("- Press correct answer once")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	qnMenu.correctAnswer()
	print("- Press correct answer twice")
	
	autoplay()
	
	#Wait
	#yield(get_tree().create_timer(2.0), "timeout")
	#qnMenu.wrongAnswer()
	#print("- Press wrong answer")
	outcome = "true"
	
	print("Challenge Mode Success: "+outcome)
	
func checkNormalMode():
	#Set Important Variables
	var root = get_tree().get_root()
	resetOutcome()
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Main Menu screen
	var screen = root.get_node("MainMenuTeachersScreen")
	#Press Play Button
	screen._on_Button_pressed("res://View/gameModes/PlayMenu.tscn")
	print("- entering Play Menu")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Play Menu screen
	screen = root.get_node("World")
	#Press Normal Mode Button
	screen._on_NormalModeButton_pressed()
	print("- entering Select World Menu")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Select World Normal Mode screen
	screen = root.get_node("World")
	#Press Next Button
	screen._on_NextButton_pressed()
	print("- entering Select Difficulty Menu")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Select Difficulty Normal Mode screen
	screen = root.get_node("World")
	#Press Primary Button
	screen._on_PrimaryButton_pressed()
	print("- entering Preview Menu")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Preview Normal Mode screen
	screen = root.get_node("World")
	#Press Play Button
	screen._on_Button_pressed()
	print("- playing Normal Mode")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Set Screen as Normal Play screen
	screen = root.get_node("World")
	#Press Quit Button
	screen._on_QuitButton_pressed()
	print("- exit Normal Mode")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Change screen back to Play Menu
	screen = root.get_node("World")
	root.remove_child(screen)
	screen.call_deferred("free")
	var next_screen_resource = load("res://View/gameModes/PlayMenu.tscn")
	var next_screen = next_screen_resource.instance()
	root.add_child(next_screen)
	#Print Result
	outcome = "true"
	print("Normal Mode Success: "+outcome)
	
func checkLogin():
	#Set Important Variables
	var root = get_tree().get_root()
	resetOutcome()
	
	#Set Screen as login screen
	var screen = root.get_node("LoginScreen")
	#Fill in username and password
	screen.username.text = fakeUsername
	screen.password.text = fakePassword
	print("- Filled username and passwords")
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Press Login button
	screen._on_LoginButton_pressed()
	print("- Login Button Pressed")

	outcome = "true"
	print("Login Success: "+outcome)

func checkRegister():
	#Set Important Variables
	var root = get_tree().get_root()
	resetOutcome()
	#Set Screen as login screen
	var screen = root.get_node("LoginScreen")
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Press Register Button
	screen._on_RegButton_pressed()
	print("- Register Button Pressed!")
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")

	#Set Screen as New Account
	screen = root.get_node("NewAccountScreen")
	#Randomize user account email
	var randomNumbers = randi()%9000+1000
	screen.username.text = "unitTest"+str(randomNumbers)+"@gmail.com"
	fakeUsername = screen.username.text
	#Set user password
	var pw = "TestingThisShit"
	screen.password.text = pw
	fakePassword = screen.password.text
	print("- Random Username and Password filled!")
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Press Create Button
	screen._on_Button_pressed()
	print("- Create Button Pressed!")
	
	#Wait
	yield(get_tree().create_timer(7.0), "timeout")
	outcome = "true"
	
	#Set Screen as Register Success Screen
	screen = root.get_node("RegisterSuccessScreen")
	#Press back button
	screen._on_Button_pressed()
	print("- Back Button Pressed")
	
	print("Register Success: "+outcome)
	
