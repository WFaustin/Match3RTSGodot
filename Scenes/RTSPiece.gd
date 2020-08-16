extends Node2D

export (int) var moveSpeed; 
export (int) var attackSpeed; 
export (int) var attackDamage; 
export (int) var attackRange; 
export (int) var healthMax; 
var health; 
var team; 



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum {move, attack, die, special}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move():
	pass;

func attack():
	pass;
	
func die():
	pass; 
	
func special():
	pass; 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
