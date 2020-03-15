extends Node


#INSERT GLOBAL VARIABLES HERE
var time = "" #String form in terms of mm:ss
var timeSeconds = 0 #Int form in terms of seconds
var highscore = 0 #Highscore for challenge mode
var storyScore = 0 #Storyscore for story mode
var characterSelected = "Godot" #Default char
var worldSelected = "World #1" #Default world
var difficultySelected = "Primary" #Default difficulty, Primary-Intermediate-Advanced
var modeSelected = "None"

#Special Powers
var rrPower = 1 #1 means normal speed, #0.5 means x2 Speed
