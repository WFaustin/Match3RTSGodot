extends Node2D

var side; 
var myTowers = []; 
var units = []; 
var towerInstancer = preload("res://Scenes/Tower.tscn"); 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnTowers();
	pass # Replace with function body.
	
	
func spawnTowers():
	for i in get_children():
		print("Here");
		var c = towerInstancer.instance(); 
		myTowers.append(c);
		i.add_child(c); 
		c.position = Vector2(0,0);


func setSide(s):
	side = s

func getSide():
	return side


#If there are no towers in, or there are only null towers in the array, return true. 
func loseCondition():
	if myTowers.size() == 0:
		return true;
	else:
		for i in myTowers:
			if i != null:
				return false; 
		return true; 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
