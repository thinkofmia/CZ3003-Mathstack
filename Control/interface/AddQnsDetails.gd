extends Node

onready var http : HTTPRequest = $HTTPRequest

#Variables
var totalQn = 1 #Total No of Qn
var newQnSet
var qnList
var Question := {
	"QuestionText":{},
	"Option1":{},
	"Option2":{},
	"Option3":{},
	"Option4":{},
	"Ans":{}
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/Label.set_text(global.worldSelected)

	totalQn = 1 #Get total number of qns here
	$ConfirmButton/Label.set_text("Save") #Replace Edit Button with Confirm Button
	newQnSet = load("res://View/util/customQuestionSet.tscn") #Sets Merged scene as custom Qn Set
	qnList = $PlayBoard/MarginContainer/VBoxContainer/Container/QnList


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AddButton_pressed():
	totalQn +=1
	#Add new instance
	var addQn = newQnSet.instance()
	#Change Question Name with its number
	addQn.get_child(0).get_child(0).set_text("Qn #"+str(totalQn)+": ")
	#Add qn to the list
	qnList.add_child(addQn)
	



func _on_ConfirmButton_pressed():
	
	# Insert saving input into firebase
	
	pass # Replace with function body.
