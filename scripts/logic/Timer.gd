extends Timer
#in terms of seconds
var timer = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 100
	updateTime()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	yield(self, "timeout")
	if (timer > 0): #If timer is still counting down
		timer -= delta #Decrement timer by delta
		updateTime()
		
	else:
		get_tree().change_scene("res://menus/gameModes/GameOver.tscn")
	
func updateTime(): #Logic to set countdown timer in terms of mins and seconds
	var seconds = int(floor(timer))
	var mins = floor(seconds/60)
	seconds =  seconds%60
	$Label.set_text(str(mins)+":"+str(seconds))
