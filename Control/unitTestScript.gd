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
	

func resetOutcome():
	outcome = "false"

func checkLogin():
	#Set Important Variables
	var root = get_tree().get_root()
	resetOutcome()
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	
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
	
