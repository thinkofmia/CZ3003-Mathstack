extends Node
#changes made here
#getting info to add into database
onready var http : HTTPRequest = $HTTPRequest
onready var http2: HTTPRequest = $HTTPRequest2
onready var hscore = int(global.highscore)
onready var character = str(global.characterSelected)
onready var username = str(global.username)
onready var time_taken = int(global.time)
onready var message = "I scored " + str(hscore) + " using " + character + " on Mathstack! Can you beat me?" 
var nickname
var ranking := {
	"character": {},
	"highscore": {},
	"time_taken": {},
	"username":{},
	"nickname":{}
}

func hideButtons(): #Hide all buttons while loading.
	$QuitButton.hide()
	$LeaderBoardButton.hide()
	$PlayButton.hide()
	$ShareButton.hide()
	$FBButton.hide()
	$WAButton.hide()
	$RedditButton.hide()
	
func showButtons():
	$QuitButton.show()
	$LeaderBoardButton.show()
	$PlayButton.show()
	$ShareButton.show()
	$FBButton.show()
	$WAButton.show()
	$RedditButton.show()

func showLabels():
	$PlayBoard/HighscoreRow.show()
	$PlayBoard/TimeElapsedRow.show()
	$PlayBoard/WorldVisitedRow.show()
	$PlayBoard/AverageSpeedRow.show()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Performance Test
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	#Hide Display
	hideButtons()
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
	#Set Worlds Visited
	var worldsVisitedList = ""
	for item in global.worldsVisited:
		if (worldsVisitedList == ""):
			worldsVisitedList += str(item)
		else:
			worldsVisitedList += ", "+str(item)
	$PlayBoard/WorldVisitedRow/ScrollContainer/Worlds.set_text(worldsVisitedList)
	#Set Average question per time
	var avg = stepify(global.highscore/global.timeSeconds,0.01)
	print(avg)
	$PlayBoard/AverageSpeedRow/SpeedPerQn.set_text(str(avg)+" qn/s")
	
	showLabels()
	
	if global.modeSelected == "Custom Mode":
		#set Fastest clear time
		
		$PlayBoard/WorldVisitedRow.hide()
		Firebase.update_document("CustomScore_" + global.customTitle + "/" + global.username,{'Score':{'integerValue':hscore}},http2)

	if global.modeSelected == "All Custom" or global.modeSelected == "My Custom":
		$PlayBoard/WorldVisitedRow.hide()
		Firebase.update_document("CustomScore_" + global.customTitle + "/" + global.username,{'Score':{'integerValue':hscore}},http2)

	
	#adding the ranking here
	ranking.username = { "stringValue" : username}
	ranking.character =  {"stringValue" : character}
	ranking.highscore = {"integerValue" : hscore}
	ranking.time_taken = {"integerValue" : time_taken}
	ranking.nickname = nickname
	#adding Ranking into Firebase.HighScore, with auto-generated ID
	Firebase.save_document("HighScore?" , ranking,http)
	
	showButtons()
	
	if global.modeSelected == "Custom Mode":
		#Hide Leaderboard Button
		$LeaderBoardButton.hide()
	else:
		$LeaderBoardButton.show()
	
	#Performance Test
	if (testPerformance.performanceCheck):
		print("Performance Test: Gameover Display & Saving Data")
		testPerformance.getTimeTaken()

func _on_LeaderBoardButton_pressed():
	
	get_tree().change_scene("res://View/teachers/LeaderboardScene.tscn")

func _on_ShareButton_pressed():
	var tweet = "https://twitter.com/intent/tweet?text="
	OS.shell_open(tweet+message)

func _on_WAButton_pressed():
	var url = "https://wa.me/?text="
	OS.shell_open(url+message)

func _on_RedditButton_pressed():
	var url = "https://reddit.com/submit?title="
	OS.shell_open(url+message)

func _on_FBButton_pressed():
	var facebook = "http://www.facebook.com/sharer.php?s=100&p[title]=MyHighScore&p[url]=http://www.facebook.com&p[summary]="
	OS.shell_open(facebook+message)

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		print("Accessed succesfully")
		self.nickname = response_body.fields["nickname"]
	pass # Replace with function body.
	


func _on_HTTPRequest2_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print("HTTP2 result")
		print(response_body)
		print("error!")
	elif response_code == 200:
		print("Accessed succesfully")
		print(response_body)
