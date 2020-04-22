extends Node


#INSERT GLOBAL VARIABLES HERE
var time = "" #String form in terms of mm:ss
var timeSeconds = 0 #Int form in terms of seconds
var highscore = 0 #Highscore for challenge mode
var storyScore = 0 #Storyscore for story mode
var questionCount = 0 #normal mode current question count
var characterSelected = "Godot" #Default char
var worldSelected = "World #2" #Default world
var worldsVisited = [] #Worlds visited array
var difficultySelected = "Primary" #Default difficulty, Primary-Intermediate-Advanced
var modeSelected = "None" # "All Custom", "My Custom", "Challenge", "Normal"
#added extra global variable that is assigned at log-in
var username ="" #string for the user playing
var accountType = "Student" #Account Type: Default Student
var classArray = ["SS1","SS2","SSP1"]
var userClass = "SS1"

#Variable to check if test mode enabled
var testMode = false

#For Admins
var targetType = "Student"
var selectedTarget = "" #Selected user target
var selectUserEdit="" #get the name of the selected user for edit
var selectQn = "" #Get name of qn selected

#Variables for Custom Mode Selected
var customTitle = "" #Variable for Custom Game Title
var customCreator = "" #Variable for Custom Game Creator
var customDate = "" #Variable for Custom Date
var customTotalQn = "" #Variable for Custom Total Questions
var customWorlds = "" #Variable for Custom Worlds
var customID = "" #Variable for Custom ID
var customScore = 0 #custom mode score variable

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
var customViewingStats = false
var viewingOverallStats = false


var difficulty=""
var world=""

#Normal mode character selected
var normalModeCharacterSelected = "Godot"

#Character Unlock Information
var characterUnlockList = [
	{
		"characterName":"Godot",
		"state":"unlocked",
		"associatedWorld":"None"
	},
	{
		"characterName":"Swee Soldier",
		"state":"locked",
		"associatedWorld":"World #1"
	},
	{
		"characterName":"Mister I",
		"state":"locked",
		"associatedWorld":"World #2"
	},
	{
		"characterName":"Humble B",
		"state":"locked",
		"associatedWorld":"World #3"
	},
	{
		"characterName":"Rider Rabbit",
		"state":"locked",
		"associatedWorld":"World #4"
	},
	{
		"characterName":"Zesty Zombie",
		"state":"locked",
		"associatedWorld":"World #5"
	},
	{
		"characterName":"Careful Cyborg",
		"state":"locked",
		"associatedWorld":"World #6"
	},
	{
		"characterName":"Deadly Dino",
		"state":"locked",
		"associatedWorld":"World #7"
	},
	{
		"characterName":"Fire Fox",
		"state":"locked",
		"associatedWorld":"World #8"
	},
	
]

func updateUnlockCharsList(fields):
	for character in characterUnlockList:
		var associatedWorld = character['associatedWorld']
		if associatedWorld != "None":
			var key = "World" + associatedWorld.split("#")[1]
			var progress = fields[key]['stringValue']
			if (progress == "3"):
				character['state'] = "unlocked"
	
	print("Updated unlocked characters list")
	print(global.getListOfUnlockedCharactersName())

func getListOfUnlockedCharactersName():
	if global.accountType != "Student":
		var namelist = []
		for character in characterUnlockList:
			namelist.append(character.characterName)
		return namelist
	else:
		var namelist = []
		for character in characterUnlockList:
			if (character.state == "unlocked"):
				namelist.append(character.characterName)
		return namelist
	
	

		
