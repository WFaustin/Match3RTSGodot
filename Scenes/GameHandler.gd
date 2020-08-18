extends Node2D


#This script will have the state machine
enum {moveGrid, moveRTS}; 
var match3; 
var rts;
var player1; 
var player2;  
var timer; 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	match3 = find_node("grid", false, true);
	rts = find_node("RTS", false, true); 
	print(match3)
	print(rts)
	player1 = get_node("RTS/Player1")
	player2 = get_node("RTS/Player2")
	timer = get_node("askForEnemies")
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Replace with function body.


 # Replace with function body.


func _on_askForEnemies_timeout():
	player1.askForNewEmenies(); 
	player2.askForNewEmenies(); 
	timer.start(); 
	pass # Replace with function body.
