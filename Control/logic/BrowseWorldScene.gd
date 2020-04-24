extends Node

#Nodes
onready var material = $Background/ControlBox #Get control box node
onready var bg = $Background #Get background node
onready var musicBox = $MusicBox #Get music box node
onready var title = $PlayBoard/TextBox/Title #Get title node
onready var text= $PlayBoard/TextBox/ScrollContainer2/Text #Get text node

var worldName = "Select a world to start" #World name header
var summary = "Waiting for world" #World text information

# Called when the node enters the scene tree for the first time.
func _ready():
	musicBox.playTrack()#Play Music
	bg.setBackground()#Set Background
	changeMaterial()#Change menu box color
	yield(get_tree().create_timer(1.0), "timeout")#Timeout 1 s
	musicBox.playTrack()#Play Music
	

#Change Background
func changeBg():
	bg.setBackground()#Set Background
	changeMaterial()#Change menu box color
	musicBox.playTrack()#Play Music

#Change Box Material
func changeMaterial():
	match global.worldSelected:#Check which world user is in and append color accordingly
		"World #1":
			material.color = Color(0, 0, 0.8, 1)
		"World #2":
			material.color = Color(0, 0.8, 0, 1)
		"World #3":
			material.color = Color(0, 0.8, 0, 1)
		"World #4":
			material.color = Color(0, 0, 0.8, 1)
		"World #5":
			material.color = Color(0.3, 0.3, 0.3, 1)
		"World #6":
			material.color = Color(0.8, 0.8, 0, 1)
		"World #7":
			material.color = Color(0.8, 0, 0, 1)
		"World #8": ###
			material.color = Color(1, 0, 0, 1)
		"World #9":
			material.color = Color(0.3, 0.3, 0.3, 1)
		"World #10":
			material.color = Color(0.8, 0.8, 0.8, 1)
		_:
			material.color = Color(1, 1, 0, 1)

#Go back to Lore type selection
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/Others/LoreTypeSelection.tscn")

func updateDisplay():#Update display
	match global.worldSelected: #set details based on world selected.
		"World #1":
			worldName = "Elementary Number Theory"
			summary = "Number theory, known to Gauss as “arithmetic,” studies the properties of theintegers:. . .−3,−2,−1,0,1,2,3. . .. Although the integers are familiar, andtheir properties might therefore seem simple, it is instead a very deep subject. "
		"World #2":
			worldName = "Propositional Logic"
			summary = "A proposition is a collection of declarative statements that has either a truth value 'true' or a truth value 'false'. A propositional consists of propositional variables and connectives. We denote the propositional variables by capital letters (A, B, etc). The connectives connect the propositional variables. Propositional Logic is concerned with statements to which the truth values, “true” and “false”, can be assigned. The purpose is to analyze these statements either individually or in a composite manner."
		"World #3":
			worldName = "Predicate Logic"
			summary = "Predicate Logic deals with predicates, which are propositions containing variables. A predicate is an expression of one or more variables defined on some specific domain. A predicate with variables can be made a proposition by either assigning a value to the variable or by quantifying the variable."
		"World #4":
			worldName = "Proof Techniques"
			summary = "A mathematical proof is an inferential argument for a mathematical statement, showing that the stated assumptions logically guarantee the conclusion. The argument may use other previously established statements, such as theorems; but every proof can, in principle, be constructed using only certain basic or original assumptions known as axioms, along with the accepted rules of inference. Proofs are examples of exhaustive deductive reasoning which establish logical certainty, to be distinguished from empirical arguments or non-exhaustive inductive reasoning which establish 'reasonable expectation'. Presenting many cases in which the statement holds is not enough for a proof, which must demonstrate that the statement is true in all possible cases. An unproven proposition that is believed to be true is known as a conjecture, or a hypothesis if frequently used as an assumption for further mathematical work. Proofs employ logic expressed in mathematical symbols, along with natural language which usually admits some ambiguity. In most mathematical literature, proofs are written in terms of rigorous informal logic. Purely formal proofs, written fully in symbolic language without the involvement of natural language, are considered in proof theory. The distinction between formal and informal proofs has led to much examination of current and historical mathematical practice, quasi-empiricism in mathematics, and so-called folk mathematics, oral traditions in the mainstream mathematical community or in other cultures. The philosophy of mathematics is concerned with the role of language and logic in proofs, and mathematics as a language. "
		"World #5":
			worldName = "Set Theory"
			summary = "Set theory is a branch of mathematical logic that studies sets, which informally are collections of objects. Although any type of object can be collected into a set, set theory is applied most often to objects that are relevant to mathematics. The language of set theory can be used to define nearly all mathematical objects. "
		"World #6":
			worldName = "Linear Recurrence Relations"
			summary = "A linear recurrence relation is an equation that relates a term in a sequence or a multidimensional array to previous terms using recursion. The use of the word linear refers to the fact that previous terms are arranged as a 1st degree polynomial in the recurrence relation."	
		"World #7":
			worldName = "Relations"
			summary = "A relation is a relationship between sets of values. In math, the relation is between the x-values and y-values of ordered pairs. The set of all x-values is called the domain, and the set of all y-values is called the range. "
		"World #8":
			worldName = "Combinatorics"
			summary = "Combinatorics is an area of mathematics primarily concerned with counting, both as a means and an end in obtaining results, and certain properties of finite structures. It is closely related to many other areas of mathematics and has many applications ranging from logic to statistical physics, from evolutionary biology to computer science, etc. "
		"World #9":
			worldName = "Functions"
			summary = "In mathematics, a function is a relation between sets that associates to every element of a first set exactly one element of the second set. Typical examples are functions from integers to integers or from the real numbers to real numbers. "
		"World #10":
			worldName = "Graph Theory"
			summary = "In mathematics, graph theory is the study of graphs, which are mathematical structures used to model pairwise relations between objects. A graph in this context is made up of vertices which are connected by edges."
		_:
			worldName = "Select a world to start" #World name header
			summary = "Waiting for world" #World text information
	title.set_text(global.worldSelected+": "+worldName) #Set title
	text.set_text(summary)#Set Text description

func _on_World1_pressed():
	global.worldSelected = "World #1" #World #1 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World2_pressed():
	global.worldSelected = "World #2" #World #2 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World3_pressed():
	global.worldSelected = "World #3" #World #3 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World4_pressed():
	global.worldSelected = "World #4" #World #4 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World5_pressed():
	global.worldSelected = "World #5" #World #5 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World6_pressed():
	global.worldSelected = "World #6" #World #6 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World7_pressed():
	global.worldSelected = "World #7" #World #7 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World8_pressed():
	global.worldSelected = "World #8" #World #8 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details

func _on_World9_pressed():
	global.worldSelected = "World #9" #World #9 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details
	
func _on_World10_pressed():
	global.worldSelected = "World #10" #World #10 Selected
	changeBg() #Change bg accordingly
	updateDisplay() #Update details
