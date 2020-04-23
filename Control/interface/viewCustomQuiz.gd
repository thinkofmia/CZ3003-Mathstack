extends Button

#Initialize selected quiz to none
var title = ""#Variable for Custom Game Title
var creator = "" #Variable for Custom Game Creator
var date = "" #Variable for Custom Date
var totalQn = "" #Variable for Custom Total Questions
var worlds = "" #Variable for Custom Worlds
var ID = "" #Variable for Custom ID

#For debug usage
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
	#get the quiz name and store it in global customTitle
	global.customTitle=get_text() 
	#print(global.customTitle)
	if global.customViewingStats:
		print("Viewing Stats for custom mode")
		get_tree().change_scene("res://View/teachers/StatisticScene.tscn")
	else:
		get_tree().change_scene("res://View/gameModes/CustomQuizModePreview.tscn")
	
