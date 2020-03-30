extends Button

#Initialize selected quiz to none
var title = ""#Variable for Custom Game Title
var creator = "" #Variable for Custom Game Creator
var date = "" #Variable for Custom Date
var totalQn = "" #Variable for Custom Total Questions
var worlds = "" #Variable for Custom Worlds
var ID = "" #Variable for Custom ID

func _ready():
	#Set Title
	title = get_text() 
	if (title == "Faker"):#To test appearance of Edit Button
		creator = "FTENG003@gmail.com"
	else:
		creator = "CharlizardXXX"
	date = "27/03/2020"
	totalQn = "10"
	worlds = "Fake Worlds"
	ID = "1231135151"

func _on_CustomQuizButton_pressed():
		#Debug
	print("Quiz Selected: "+title)
	#Set globals
	#global.customTitle = title
	#global.customCreator = creator
	#global.customDate = date
	#global.customTotalQn = totalQn
	#global.customWorlds = worlds
	#global.customID = ID
	#Sent user to custom quiz preview
	get_tree().change_scene("res://View/gameModes/CustomQuizModePreview.tscn")
