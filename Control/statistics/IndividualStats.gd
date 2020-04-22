extends Node


# Declare member variables here. Examples:
onready var header = $TemplateScreen/Header
onready var challenge = $PlayBoard/ScrollContainer/StatsDisplay/ChallengeRow/ChallengeScore
onready var world1 = $PlayBoard/ScrollContainer/StatsDisplay/World1Row/World1Score
onready var world2 = $PlayBoard/ScrollContainer/StatsDisplay/World2Row/World2Score
onready var world3 = $PlayBoard/ScrollContainer/StatsDisplay/World3Row/World3Score
onready var world4 = $PlayBoard/ScrollContainer/StatsDisplay/World4Row/World4Score
onready var world5 = $PlayBoard/ScrollContainer/StatsDisplay/World5Row/World5Score
onready var world6 = $PlayBoard/ScrollContainer/StatsDisplay/World6Row/World6Score
onready var world7 = $PlayBoard/ScrollContainer/StatsDisplay/World7Row/World7Score
onready var world8 = $PlayBoard/ScrollContainer/StatsDisplay/World8Row/World8Score
onready var world9 = $PlayBoard/ScrollContainer/StatsDisplay/World9Row/World9Score
onready var world10 = $PlayBoard/ScrollContainer/StatsDisplay/World10Row/World10Score


# Called when the node enters the scene tree for the first time.
func _ready():
	#Set header of target
	header.set_text("View Statistics by Individual: "+global.selectedTarget)
	#Set Scores
	setScores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func setScores(): #Set scores of target
	var fakeScore = "3"
	###Add firebase here
	world1.set_text(str(fakeScore))
	world2.set_text(str(fakeScore))
	world3.set_text(str(fakeScore))
	world4.set_text(str(fakeScore))
	world5.set_text(str(fakeScore))
	world6.set_text(str(fakeScore))
	world7.set_text(str(fakeScore))
	world8.set_text(str(fakeScore))
	world9.set_text(str(fakeScore))
	world10.set_text(str(fakeScore))
	challenge.set_text(str(fakeScore))
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/ViewStudent.tscn")
