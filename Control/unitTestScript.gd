extends Node

#This is a script meant for unit testing
#Written by Fremont Teng 
#Last Updated (20/02/20)
#To enable this script, go to Project > Project Setting > AutoLoad
#Then check the Simpleton checkbox for unitTestScript.gd and run the program

# Declare member variables here.
var outcome = false #True means success, #False means one or more mistake exists

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting Test Script...")
	#Check if register works
	checkRegister()
	print("Register Success: "+str(outcome))
	resetOutcome()
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")

func resetOutcome():
	outcome = false

func checkRegister():
	#Set Important Variables
	var root = get_tree().get_root()
	outcome = false	
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
	#Set user password
	var pw = "TestingThisShit"
	screen.password.text = pw
	print("- Random Username and Password filled!")
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	#Press Create Button
	screen._on_Button_pressed()
	print("- Create Button Pressed!")
	
	#Wait
	yield(get_tree().create_timer(2.0), "timeout")
	outcome = true
