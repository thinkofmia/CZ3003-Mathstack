extends Node
#changes made here
#getting info to add into database
onready var http : HTTPRequest = $HTTPRequest
onready var hscore = int(global.highscore)
onready var character = str(global.characterSelected)
onready var username = str(global.username)
onready var time_taken = int(global.time)
var nickname
var ranking := {
	"character": {},
	"highscore": {},
	"time_taken": {},
	"username":{},
	"nickname":{}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#Hide health and power button
	$SelectedCharacter/healthBar.hide()
	$SelectedCharacter/PowerButton.hide()
	$SelectedCharacter.displayCharacter()
	##Getting the nickname of the user
	Firebase.get_document("users/%s" % Firebase.user_info.email, http)
	yield(get_tree().create_timer(1), "timeout")
	$PlayBoard/HighscoreRow/Score.set_text(str(global.highscore))
	#Set Time
	$PlayBoard/TimeElapsedRow/Time.set_text(str(global.time))
	#Set Block No
	$Block/Label.set_text(str(global.highscore))
	#Set World
	$PlayBoard/WorldVisitedRow/Worlds.set_text(global.worldSelected)
	#Set Average question per time
	var avg = stepify(global.highscore/global.timeSeconds,0.01)
	print(avg)
	$PlayBoard/AverageSpeedRow/SpeedPerQn.set_text(str(avg)+" qn/s")
	
	#adding the ranking here
	ranking.username = { "stringValue" : username}
	ranking.character =  {"stringValue" : character}
	ranking.highscore = {"integerValue" : hscore}
	ranking.time_taken = {"integerValue" : time_taken}
	ranking.nickname = nickname
	#adding Ranking into Firebase.HighScore, with auto-generated ID
	Firebase.save_document("HighScore?" , ranking,http)

func _on_LeaderBoardButton_pressed():
	
	get_tree().change_scene("res://View/teachers/LeaderboardScene.tscn")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		print("Accessed succesfully")
		self.nickname = response_body.fields["nickname"]
	pass # Replace with function body.
	



