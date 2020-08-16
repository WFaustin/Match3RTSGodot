extends Node2D

export (String) var loadScene = "res://Scenes/MainScene.tscn"; 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func loadNextScene():
	if Input.is_action_pressed("ui_touch"):
		get_tree().change_scene(loadScene); 
		print("Hi");
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loadNextScene(); 
