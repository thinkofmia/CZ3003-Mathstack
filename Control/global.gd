extends Node


#INSERT GLOBAL VARIABLES HERE
var time = "" #String form in terms of mm:ss
var timeSeconds = 0 #Int form in terms of seconds
var highscore = 0 #Highscore for challenge mode
var storyScore = 0 #Storyscore for story mode
var questionCount = 0 #normal mode current question count
var characterSelected = "Deadly Dino" #Default char
var worldSelected = "World #2" #Default world
var difficultySelected = "Primary" #Default difficulty, Primary-Intermediate-Advanced
var modeSelected = "None"
#added extra global variable that is assigned at log-in
var username ="" #string for the user playing

#Variable to check if test mode enabled
var testMode = false

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
}
