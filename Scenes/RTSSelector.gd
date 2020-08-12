extends Node2D

#Variables to instantiate the piece
export (int) var rtsPiece
var rtsPieceInstance
var myPiece

var allRTSPieces = [
	preload("res://Scenes/DPSRTSPiece.tscn"), 
	preload("res://Scenes/WarriorRTSPiece.tscn"),
	preload("res://Scenes/TankRTSPiece.tscn"), 
	preload("res://Scenes/HealerRTSPiece.tscn"), 
	preload("res://Scenes/ChargerRTSPiece.tscn")
]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func dimMatchedPieces(check):
	var sprite = get_node("Sprite"); 
	if check:
		sprite.modulate.a = 1;
	else:
		sprite.modulate.a = .3;
	pass;

# Called when the node enters the scene tree for the first time.
func setRTSPieceInstance():
	rtsPieceInstance = allRTSPieces[rtsPiece]; 

func _ready():
	setRTSPieceInstance(); 
	pass # Replace with function body.

func addPiece(piece):
	var s = get_node("PieceIndicator").add_child(piece)
	myPiece = piece
	return s
	
func addRTSPiece():
	return rtsPieceInstance.instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
