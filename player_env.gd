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
	
func flipUnit(unit):
	print("AT Flipping unit")
	if side == "left" and unit.isfacingLeft or side == "right" and !unit.isfacingLeft:
		print("Flipping unit")
		unit.flipAround()
	
	
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
	
func addUnits(unit):
	units.append(unit); 

#If there are no towers in, or there are only null towers in the array, return true. 
func loseCondition():
	if myTowers.size() == 0:
		return true;
	else:
		for i in myTowers:
			if i != null:
				return false; 
		return true; 

func addRTSPieceatSpawnPosition(piece, mouseClick):
	var closestDistance = 576; 
	var towerpos; 
	var pos; 
	for i in myTowers:
		for j in i.getSpawnPoints():
			var xdist = j.x - mouseClick.x;
			var ydist = j.y - mouseClick.y;
			var dist = sqrt(pow(xdist, 2) + pow(ydist, 2));
			if closestDistance > dist:
				closestDistance = dist; 
				towerpos = i;
				pos = j;
	print(pos)
	piece.position = pos; 
	add_child(piece); 
	addUnits(piece); 
	flipUnit(piece); 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
