extends Node2D

export (int) var moveSpeed; 
export (int) var attackSpeed; 
export (int) var attackDamage; 
export (float) var attackRange; 
export (int) var healthMax;
export (bool) var isfacingLeft;
var sprite;  
var health; 
var team; 
var state; 
var target; 
var allTargets; 

var velocity = Vector2(); 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum {start, move, firstattack, attack, die, special}


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite");
	state = start; 
	pass # Replace with function body.

func move():
	if team.side == "left":
		velocity.x += .4; 
	else:
		velocity.x -= .4; 
	velocity = velocity.normalized() * moveSpeed; 
	self.position += velocity;
	if self.position.x > 576 or self.position.x < 0:
		  state = die; 
	if isTarInRange():
		velocity = Vector2(0,0); 
		print("AHHHHHHHHHHHHHHHHHHHHH")
		state = firstattack; 

func attack():
	if isTarInRange():
		target.subtractHealth(attackDamage);
	else:
		state = die; 
	
func die():
	self.queue_free();
	
func special():
	pass; 
	
func subtractHealth(amount):
	health -= amount; 
	if health < 0:
		health = 0; 
		state = die; 
	if health > healthMax:
		health = healthMax; 
	
func makeTarget(tar):
	target = tar; 
	
func isTarInRange():
	if target == null:
		findClosestTarget();
		if target == null:
			return false; 
	var rayCastpos = get_node("FakeRaycast").global_position;
	print(rayCastpos); 
	var tarPos = target.global_position; 
	print(tarPos);
	var xdist = rayCastpos.x - tarPos.x;
	var ydist = rayCastpos.y - tarPos.y;
	var dist = sqrt(pow(xdist, 2) + pow(ydist, 2));
	print(dist); 
	if dist <= attackRange:
		return true; 
	else:
		return false; 

func flipAround():
	print("in flip around")
	isfacingLeft = !isfacingLeft; 
	self.scale.x *= -1; 
	
func findClosestTarget():
	var closestTargetDis = null; 
	var closestTarget = null;
	var rayCastpos = get_node("FakeRaycast").global_position
	for i in allTargets:
		if i != null:
			var tarPos = i.global_position; 
			var xdist = rayCastpos.x - tarPos.x;
			var ydist = rayCastpos.y - tarPos.y;
			var dist = sqrt(pow(xdist, 2) + pow(ydist, 2));
			if closestTargetDis == null:
				closestTargetDis = dist
				closestTarget = i; 
			if closestTargetDis > dist:
				closestTargetDis = dist
				closestTarget = i
	if closestTarget != null:
		target = closestTarget;
	else:
		state = die; 
	print(target)
	 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == start:
		state = move; 
		findClosestTarget();
	elif state == move:
		move(); 
		findClosestTarget();
	elif state == firstattack:
		attack(); 
		state == attack; 
	elif state == attack:
		if get_node("attackspeedtimer").time_left == attackSpeed:
			get_node("attackspeedtimer").start(); 
	elif state == die:
		die();
	

func findEnemiesFromPlayer(allEnemies):
	allTargets = allEnemies; 
	findClosestTarget();

func _on_attackspeedtimer_timeout():
	attack(); 
	if isTarInRange():
		state = attack(); 
	pass # Replace with function body.
