extends Control

#Set respective nodes as vars
onready var track01 = $PlayMusic
onready var track02 = $track02
onready var track03 = $track03
onready var track04 = $track04
onready var track05 = $track05
onready var track06 = $track06
onready var track07 = $track07
onready var track08 = $track08
onready var track09 = $track09
onready var track10 = $track10
onready var trackMenu = $MainMusic
onready var bossMusic = $BossMusic
onready var fastForward = $FFMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	playMenuMusic()

#Main menu music
func playMenuMusic():
	trackMenu.play()

#Boss theme
func bossTheme():
	stopMusic()
	bossMusic.play()

#Play theme
func playTrack():
	#Stop all music
	stopMusic()
	#Timeout
	yield(get_tree().create_timer(1.0), "timeout")
	#Play music based on world selected
	match global.worldSelected:
		"World #1":
			track01.play()
		"World #2":
			track02.play()
		"World #3":
			track03.play()
		"World #4":
			track04.play()
		"World #5":
			track05.play()
		"World #6":
			track06.play()
		"World #7":
			track07.play()
		"World #8":
			track08.play()
		"World #9":
			track09.play()
		"World #10":
			track10.play()	
		_:
			track01.play()

#Stop all music
func stopMusic():
	track01.stop()
	track02.stop()
	track03.stop()
	track04.stop()
	track05.stop()
	track06.stop()
	track07.stop()
	track08.stop()
	track09.stop()
	track10.stop()
	trackMenu.stop()
	bossMusic.stop()
	fastForward.stop()

#Power music
func fastForward():
	stopMusic()
	fastForward.play()
