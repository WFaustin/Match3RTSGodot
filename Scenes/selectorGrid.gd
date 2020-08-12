extends Node2D

export (int) var selectorx_start; 
export (int) var selectory_start; 
export (int) var selector_offset; 

var allSelectors = []; 
var possibleSelectors = [
	preload("res://Scenes/DPSRTSSelector.tscn"), 
	preload("res://Scenes/WarriorRTSSelector.tscn"),
	preload("res://Scenes/TankRTSSelector.tscn"), 
	preload("res://Scenes/HealerRTSSelector.tscn"), 
	preload("res://Scenes/ChargerRTSSelector.tscn")
];

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass; # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
