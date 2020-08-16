extends Node2D


#This script will have the state machine
enum {moveGrid, moveRTS}; 
var match3; 
var rts;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	match3 = find_node("grid", false, true);
	rts = find_node("RTS", false, true); 
	print(match3)
	print(rts)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
