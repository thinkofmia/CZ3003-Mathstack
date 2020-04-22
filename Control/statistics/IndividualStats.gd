extends Node


# Declare member variables here. Examples:
onready var http : HTTPRequest = $HTTPRequest
onready var header = $TemplateScreen/Header
onready var challenge = $PlayBoard/ScrollContainer/StatsDisplay/ChallengeRow/ChallengeScore
onready var world1 = $PlayBoard/ScrollContainer/StatsDisplay/World1Row/World1Score
var w1 = 0
onready var world2 = $PlayBoard/ScrollContainer/StatsDisplay/World2Row/World2Score
var w2 = 0
onready var world3 = $PlayBoard/ScrollContainer/StatsDisplay/World3Row/World3Score
var w3 = 0
onready var world4 = $PlayBoard/ScrollContainer/StatsDisplay/World4Row/World4Score
var w4 = 0
onready var world5 = $PlayBoard/ScrollContainer/StatsDisplay/World5Row/World5Score
var w5 = 0
onready var world6 = $PlayBoard/ScrollContainer/StatsDisplay/World6Row/World6Score
var w6 = 0
onready var world7 = $PlayBoard/ScrollContainer/StatsDisplay/World7Row/World7Score
var w7 = 0
onready var world8 = $PlayBoard/ScrollContainer/StatsDisplay/World8Row/World8Score
var w8 = 0
onready var world9 = $PlayBoard/ScrollContainer/StatsDisplay/World9Row/World9Score
var w9 = 0
onready var world10 = $PlayBoard/ScrollContainer/StatsDisplay/World10Row/World10Score
var w10 = 0
onready var challenge_score = []
onready var normal_scores = []
onready var isLeaderboard
var isAttempted = 0
var no_attempt = '0'
var challenge_text
var display
# Called when the node enters the scene tree for the first time.
func _ready():
	isLeaderboard = 1
	Firebase.get_document("Leaderboard", http)
	yield(get_tree().create_timer(2), "timeout")
	isLeaderboard = 0
	Firebase.get_document("SaveData/%s" % global.selectedTarget, http)
	for items in challenge_score.values()[0]:
		if items['fields']['username'].values()[0] == global.selectedTarget:
			challenge_text = items['fields']['highscore'].values()[0]
			break
	yield(get_tree().create_timer(1), "timeout")
	if isAttempted:
		display = getScores(normal_scores)
	
	header.set_text("View Statistics by Individual: "+global.selectedTarget)
	#Set Scores
	setScores(display,isAttempted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func getScores(data):
	w1 += int(data['ScoreWorld1a'].values()[0])
	w1 += int(data['ScoreWorld1b'].values()[0])
	w1 += int(data['ScoreWorld1c'].values()[0])
	
	w2 += int(data['ScoreWorld2a'].values()[0])
	w2 += int(data['ScoreWorld2b'].values()[0])
	w2 += int(data['ScoreWorld2c'].values()[0])
	
	w3 += int(data['ScoreWorld3a'].values()[0])
	w3 += int(data['ScoreWorld3b'].values()[0])
	w3 += int(data['ScoreWorld3c'].values()[0])
	
	w4 += int(data['ScoreWorld4a'].values()[0])
	w4 += int(data['ScoreWorld4b'].values()[0])
	w4 += int(data['ScoreWorld4c'].values()[0])
	
	w5 += int(data['ScoreWorld5a'].values()[0])
	w5 += int(data['ScoreWorld5b'].values()[0])
	w5 += int(data['ScoreWorld5c'].values()[0])
	
	w6 += int(data['ScoreWorld6a'].values()[0])
	w6 += int(data['ScoreWorld6b'].values()[0])
	w6 += int(data['ScoreWorld6c'].values()[0])
	
	w7 += int(data['ScoreWorld7a'].values()[0])
	w7 += int(data['ScoreWorld7b'].values()[0])
	w7 += int(data['ScoreWorld7c'].values()[0])
	
	w8 += int(data['ScoreWorld8a'].values()[0])
	w8 += int(data['ScoreWorld8b'].values()[0])
	w8 += int(data['ScoreWorld8c'].values()[0])
	
	w9 += int(data['ScoreWorld9a'].values()[0])
	w9 += int(data['ScoreWorld9b'].values()[0])
	w9 += int(data['ScoreWorld9c'].values()[0])
	
	w10 += int(data['ScoreWorld10a'].values()[0])
	w10 += int(data['ScoreWorld10b'].values()[0])
	w10 += int(data['ScoreWorld10c'].values()[0])
	var result = [w1,w2,w3,w4,w5,w6,w7,w8,w9,w10]
	
	return result

func setScores(display,isAttempted): #Set scores of target
	###Add firebase here
	if isAttempted:
		world1.set_text(str(display[0]))
		world2.set_text(str(display[1]))
		world3.set_text(str(display[2]))
		world4.set_text(str(display[3]))
		world5.set_text(str(display[4]))
		world6.set_text(str(display[5]))
		world7.set_text(str(display[6]))
		world8.set_text(str(display[7]))
		world9.set_text(str(display[8]))
		world10.set_text(str(display[9]))
	else:
		world1.set_text(str(no_attempt))
		world2.set_text(str(no_attempt))
		world3.set_text(str(no_attempt))
		world4.set_text(str(no_attempt))
		world5.set_text(str(no_attempt))
		world6.set_text(str(no_attempt))
		world7.set_text(str(no_attempt))
		world8.set_text(str(no_attempt))
		world9.set_text(str(no_attempt))
		world10.set_text(str(no_attempt))
	challenge.set_text(str(challenge_text))
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/ViewStudent.tscn")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		print("Accessed succesfully")
		if isLeaderboard:
			self.challenge_score = response_body
		else:
			self.isAttempted = 1
			self.normal_scores = response_body['fields']
