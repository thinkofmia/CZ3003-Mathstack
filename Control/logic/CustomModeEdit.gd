extends Node

#Variables
var totalQn = 1 #Total No of Qn
var newQnSet
var qnList
var id = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	totalQn = 1 #Get total number of qns here
	$ConfirmButton/Label.set_text("Save") #Replace Edit Button with Confirm Button
	newQnSet = load("res://View/util/customQuestionSet.tscn") #Sets Merged scene as custom Qn Set
	qnList = $PlayBoard/Container/QnList

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed(): #Exit Scene
	get_tree().change_scene("res://View/gameModes/CustomModeMyQuizzes.tscn")


func _on_AddButton_pressed(): #Add new Qn 
	totalQn +=1
	#Add new instance
	var addQn = newQnSet.instance()
	#Change Question Name with its number
	addQn.get_child(0).get_child(0).set_text("Qn #"+str(totalQn)+": ")
	#Add qn to the list
	qnList.add_child(addQn)


func _on_ConfirmButton_pressed(): #Save Quiz
	var name = $PlayBoard/TitleRow/LineEdit2.get_text() #Quiz Title
	print("Quiz Name: "+str(name)+" Total Qn: "+str(totalQn)) #Quiz Name and Total Qns
	var date = "29/03/20" #Date of Creation/Update - Hard code for now
	var worlds = "Custom" #Worlds involved - Hard code for now (Probably might be removed)
	id = $PlayBoard/IDRow/LineEdit2.get_text() #Get quiz id
	var username = global.username #Creator's name
	print("Quiz ID: "+str(id)+" Created By: "+str(username)) #Print quiz ID
	print(" ")
	for i in range(1,totalQn+1): #Loop For Total Number of Qn
		var qnSet = qnList.get_child(i-1) #Save as qn set
		var qnTitle = qnSet.get_child(0).get_child(0).get_text() #Qn Title
		var option1 = qnSet.get_child(1).get_child(1).get_text() #Option 1
		var option2 = qnSet.get_child(2).get_child(1).get_text() #Option 2
		var option3 = qnSet.get_child(3).get_child(1).get_text() #Option 3
		var option4 = qnSet.get_child(4).get_child(1).get_text() #Option 4
		var ans = qnSet.get_child(5).get_child(1).get_text() #Option 1
		
		#For Debugging and getting each vars
		print("Q"+str(i)+": "+str(qnTitle)) #Print Qn No and Text
		print(">Options: ["+str(option1)+", "+str(option2)+", "+str(option3)+", "+str(option4)+"]") #Print options 
		print(">Ans: "+str(ans)) #Print correct ans
		print(" ")
		
