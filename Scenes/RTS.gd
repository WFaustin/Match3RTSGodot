extends Node2D

var players = []; 
var player1;
var player2; 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	setUpRTS(); 
	pass # Replace with function body.


func setUpRTS():
	for i in get_children():
		if !(i is Timer):
			players.append(i); 
			i.spawnTowers(); 
	player1 = players[0];
	player2 = players[1]; 

	


func checkWhoWon():
	var p1win = player1.loseCondition(); 
	var p2win = player2.loseCondition(); 
	if p1win and p2win:
		print("Draw!"); 
		Endwinner.winnernum = 3; 
		get_tree().change_scene("res://Scenes/EndGameMenu.tscn"); 
	elif p1win and !p2win:
		print("P2 wins!"); 
		Endwinner.winnernum = 2; 
		get_tree().change_scene("res://Scenes/EndGameMenu.tscn"); 
	elif !p1win and p2win:
		print("P1 wins!"); 
		Endwinner.winnernum = 1; 
		get_tree().change_scene("res://Scenes/EndGameMenu.tscn"); 
	#else:
		#print("No one's won yet!"); 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkWhoWon();
#	pass
