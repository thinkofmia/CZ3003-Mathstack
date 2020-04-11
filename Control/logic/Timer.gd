extends Timer
#in terms of seconds
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	global.timeSeconds = 0
	timer = 0
	updateTime()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		timer += delta*global.rrPower #Decrement timer by delta
		if timer<0:
			timer = 0
		updateTime()

func getTime():
	return $Label.get_text()

func updateTime(): #Logic to set countdown timer in terms of mins and seconds
	var seconds = int(floor(timer))
	#Save character var
	var character = get_tree().get_root().get_node("World").find_node("SelectedCharacter")
	#Save time in terms of seconds
	global.timeSeconds = timer
	
	#Recover power every 2mins
	if (seconds % 120)== 119:
		character.recoverPower()
	#calculate min
	var mins = floor(seconds/60)
	seconds =  seconds%60
	if (seconds<10):
		 seconds = "0" +str(seconds)
	$Label.set_text(str(mins)+":"+str(seconds))
	global.time = getTime()
