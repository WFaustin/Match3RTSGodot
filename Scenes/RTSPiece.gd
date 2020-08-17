extends Node2D

export (int) var moveSpeed; 
export (int) var attackSpeed; 
export (int) var attackDamage; 
export (int) var attackRange; 
export (int) var healthMax;
export (bool) var isfacingLeft;
var sprite;  
var health; 
var team; 
var state; 

var velocity = Vector2(); 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum {start, move, attack, die, special}


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite");
	state = start; 
	pass # Replace with function body.

func move():
	if team.side == "left":
		velocity.x += 1; 
	else:
		velocity.x -= 1; 
	velocity = velocity.normalized() * moveSpeed; 
	self.position += velocity;
	if self.position.x > 576:
		  self.queue_free();
	pass;

func attack():
	pass;
	
func die():
	pass; 
	
func special():
	pass; 


func flipAround():
	print("in flip around")
	isfacingLeft = !isfacingLeft; 
	self.scale.x *= -1; 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == start:
		state = move; 
	elif state == move:
		move(); 

