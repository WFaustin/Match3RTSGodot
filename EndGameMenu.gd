extends Node2D

export (String) var loadScene = "res://Scenes/MainScene.tscn"; 
export (int) var spriteNeeded = 1; 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spriteNeeded = Endwinner.winnernum; 
	pass # Replace with function body.

func hideSprites():
	if spriteNeeded == 1:
		get_node("Background/Player 1 Wins").visible; 
	elif spriteNeeded == 2:
		get_node("Background/Player 2 Wins").visible;
	elif spriteNeeded == 3:
		get_node("Background/Draw").visible;

func loadNextScene():
	if Input.is_action_pressed("ui_touch"):
		get_tree().change_scene(loadScene); 
		print("Hi");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loadNextScene(); 
#	pass
