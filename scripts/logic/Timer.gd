extends Timer
#in terms of seconds
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 0
	updateTime()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		timer += delta #Decrement timer by delta
		updateTime()
	
func updateTime(): #Logic to set countdown timer in terms of mins and seconds
	var seconds = int(floor(timer))
	var mins = floor(seconds/60)
	seconds =  seconds%60
	if (seconds<10):
		 seconds = "0" +str(seconds)
	$Label.set_text(str(mins)+":"+str(seconds))
