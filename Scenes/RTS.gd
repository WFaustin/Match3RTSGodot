extends Node2D

var players = []; 
var player1;
var player2; 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func setUpRTS():
	for i in get_children():
		players.append(i); 
	player1 = players[0];
	player2 = players[1]; 


func checkWhoWon():
	var p1win = player1.loseCondition(); 
	var p2win = player2.loseCondition(); 
	if p1win and p2win:
		print("Draw!"); 
	elif p1win and !p2win:
		print("P2 wins!"); 
	elif !p1win and p2win:
		print("P1 wins!"); 
	else:
		print("No one's won yet!"); 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
