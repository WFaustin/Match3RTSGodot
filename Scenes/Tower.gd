extends Node2D

var health; 
export (int) var healthMax; 
var spawnPoints = []; 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	startingHealth(); 
	setSpawnPoints(); 
	pass # Replace with function body.


func getSpawnPoints():
	return spawnPoints; 

func setSpawnPoints():
	var s = get_node("SpawnPoint").get_children(); 
	for i in s:
		spawnPoints.append(i.global_position); 
	pass; 
	
func startingHealth():
	health = healthMax; 	

func getHealth():
	return health; 
	
func subtractHealth(number):
	health -= number; 
	if health < 0:
		health = 0;
	if health > healthMax:
		health = healthMax; 
		
func changeHealthMax(number):
	healthMax = number; 
	subtractHealth(0); 

func getmaxHealth():
	return healthMax;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClickingPoint_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
