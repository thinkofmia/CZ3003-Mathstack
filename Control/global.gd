extends Node


#INSERT GLOBAL VARIABLES HERE
var time = "" #String form in terms of mm:ss
var timeSeconds = 0 #Int form in terms of seconds
var highscore = 0 #Highscore for challenge mode
var storyScore = 0 #Storyscore for story mode
var questionCount = 0 #normal mode current question count
var characterSelected = "Deadly Dino" #Default char
var worldSelected = "World #2" #Default world
var worldsVisited = [] #Worlds visited array
var difficultySelected = "Primary" #Default difficulty, Primary-Intermediate-Advanced
var modeSelected = "None" # "All Custom", "My Custom", "Challenge", "Normal"
#added extra global variable that is assigned at log-in
var username ="" #string for the user playing
var accountType = "Student" #Account Type: Default Student

#Variable to check if test mode enabled
var testMode = false

#Variables for Custom Mode Selected
var customTitle = "" #Variable for Custom Game Title
var customCreator = "" #Variable for Custom Game Creator
var customDate = "" #Variable for Custom Date
var customTotalQn = "" #Variable for Custom Total Questions
var customWorlds = "" #Variable for Custom Worlds
var customID = "" #Variable for Custom ID

#Special Powers
var rrPower = 1 #1 means normal speed, #0.5 means x2 Speed
var ddPower = 0

var save := {
	"World1":{"stringValue" : "0"},
	"World2":{"stringValue" : "0"},
	"World3":{"stringValue" : "0"},
	"World4":{"stringValue" : "0"},
	"World5":{"stringValue" : "0"},
	"World6":{"stringValue" : "0"},
	"World7":{"stringValue" : "0"},
	"World8":{"stringValue" : "0"},
	"World9":{"stringValue" : "0"},
	"World10":{"stringValue" : "0"},
	"ScoreWorld1a":{"stringValue" : "0"},
	"ScoreWorld2a":{"stringValue" : "0"},
	"ScoreWorld3a":{"stringValue" : "0"},
	"ScoreWorld4a":{"stringValue" : "0"},
	"ScoreWorld5a":{"stringValue" : "0"},
	"ScoreWorld6a":{"stringValue" : "0"},
	"ScoreWorld7a":{"stringValue" : "0"},
	"ScoreWorld8a":{"stringValue" : "0"},
	"ScoreWorld9a":{"stringValue" : "0"},
	"ScoreWorld10a":{"stringValue" : "0"},
	"ScoreWorld1b":{"stringValue" : "0"},
	"ScoreWorld2b":{"stringValue" : "0"},
	"ScoreWorld3b":{"stringValue" : "0"},
	"ScoreWorld4b":{"stringValue" : "0"},
	"ScoreWorld5b":{"stringValue" : "0"},
	"ScoreWorld6b":{"stringValue" : "0"},
	"ScoreWorld7b":{"stringValue" : "0"},
	"ScoreWorld8b":{"stringValue" : "0"},
	"ScoreWorld9b":{"stringValue" : "0"},
	"ScoreWorld10b":{"stringValue" : "0"},
	"ScoreWorld1c":{"stringValue" : "0"},
	"ScoreWorld2c":{"stringValue" : "0"},
	"ScoreWorld3c":{"stringValue" : "0"},
	"ScoreWorld4c":{"stringValue" : "0"},
	"ScoreWorld5c":{"stringValue" : "0"},
	"ScoreWorld6c":{"stringValue" : "0"},
	"ScoreWorld7c":{"stringValue" : "0"},
	"ScoreWorld8c":{"stringValue" : "0"},
	"ScoreWorld9c":{"stringValue" : "0"},
	"ScoreWorld10c":{"stringValue" : "0"},
}

##stat screen variable
var statWorldSelected = 1


var difficulty=""
var world=""
