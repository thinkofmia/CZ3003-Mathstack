extends Node


# Declare member variables here. 
var performanceCheck = true #Change this to run/off the script
var timeTaken = 0
var timeTakenSaved = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeTaken += delta

func startTime():
	timeTaken = 0

func saveTime():
	timeTakenSaved = timeTaken

func getTimeTaken():
	var seconds = int(round(timeTaken))%60
	var minutes = int(round(timeTaken))/60
	print("-> Time taken: "+str(minutes)+"m "+str(seconds)+"s ")
