extends Node2D


#Grid Variables
export (int) var width; 
export (int) var height; 
export (int) var x_start; 
export (int) var y_start; 
export (int) var offset; 
export (int) var y_offset; 
export (int) var selectorx_start; 
export (int) var selectory_start; 
export (int) var selector_offset; 
export (int) var playernum; 
var player; 
var controlling = false;
var selectorChoice = false;  

#state Machine
enum {wait, move}
var state; 

#Pieces on the grid
var allPieces = []; 
var allSelectors = []; 
var allColorsMatched = []; 

#The scene base pieces
var possiblePieces = [
	preload("res://Scenes/YellowPiece.tscn"), 
	preload("res://Scenes/OrangePiece.tscn"),
	preload("res://Scenes/PinkPiece.tscn"), 
	preload("res://Scenes/GreenPiece.tscn"), 
	preload("res://Scenes/BluePiece.tscn")
]; 
var possibleSelectors = [
	preload("res://Scenes/DPSRTSSelector.tscn"), 
	preload("res://Scenes/WarriorRTSSelector.tscn"),
	preload("res://Scenes/TankRTSSelector.tscn"), 
	preload("res://Scenes/HealerRTSSelector.tscn"), 
	preload("res://Scenes/ChargerRTSSelector.tscn")
];
#Touch variables
var firstTouch = Vector2(0, 0); 
var finalTouch = Vector2(0, 0); 


# Called when the node enters the scene tree for the first time.
func _ready():
	#state = move; 
	create2DArray(); 
	randomize(); 
	spawnPieces(); 
	spawnSelectors(); 
	setPlayer(); 
	pass # Replace with function body.


func setPlayer():
	if playernum == 1:
		player = get_parent().get_node("RTS/Player1"); 
		player.setSide("left"); 
		get_parent().get_node("RTS/Player2").setSide("right");
	elif playernum == 2:
		player = get_parent().get_node("RTS/Player2"); 
		player.setSide("right");
		get_parent().get_node("RTS/Player1").setSide("left");
	else:
		print("Error with getting player.");
	

func touchInput():
	var gridPosFirst; 
	var gridPosFinal; 
	var selectorgridFirst; 
	if Input.is_action_just_pressed("ui_touch"):
		firstTouch = get_global_mouse_position();
		gridPosFirst = convertPixelToGrid(firstTouch.x, firstTouch.y);
		selectorgridFirst = convertPixelToGridSelector(firstTouch.x,firstTouch.y); 
		if isPieceInGrid(gridPosFirst.x, gridPosFirst.y):
			controlling = true;
			selectorChoice = false; 
		elif isPieceInSelector(selectorgridFirst):
			selectorChoice = true; 
			controlling = false;
	if Input.is_action_just_released("ui_touch"):
		finalTouch = get_global_mouse_position(); 
		gridPosFirst = convertPixelToGrid(firstTouch.x, firstTouch.y);
		gridPosFinal = convertPixelToGrid(finalTouch.x, finalTouch.y);
		selectorgridFirst = convertPixelToGridSelector(firstTouch.x,firstTouch.y); 
		if isPieceInGrid(gridPosFinal.x, gridPosFinal.y) and controlling and !(gridPosFirst.x == gridPosFinal.x and gridPosFirst.y == gridPosFinal.y):
			swapPieces(gridPosFirst.x, gridPosFirst.y, gridPosFinal.x, gridPosFinal.y);
		elif isPieceInSelector(selectorgridFirst) and selectorChoice and finalTouch.y < 499 and checkIfRTSPieceFilled(allSelectors[selectorgridFirst]):
			print("Piece will be spawned");
			var s = addRTSPiece(allSelectors[selectorgridFirst]);
			allColorsMatched.erase(allSelectors[selectorgridFirst].myPiece.color); 
			partiallyFilledSelectors();
			player.addRTSPieceatSpawnPosition(s, finalTouch); 
			#s.position = finalTouch;
			#get_parent().get_node("RTS Part").add_child(s);
		controlling = false;
		selectorChoice = false;  
	pass; 

func swapPieces(column, row, columnrel, rowrel):
	if allPieces[column][row] != null and allPieces[columnrel][rowrel] != null:
		var firstPiece = allPieces[column][row]; 
		var nextPiece = allPieces[columnrel][rowrel]; 
		allPieces[column][row] = nextPiece; 
		allPieces[columnrel][rowrel] = firstPiece; 
		firstPiece.move(convertGridToPixel(columnrel, rowrel)); 
		nextPiece.move(convertGridToPixel(column, row)); 
		print("Switched Piece at: " + String(column) + ", " + String(row) + " with Piece at: " + String(columnrel) + ", " + String(rowrel)); 
		findMatches();
	else:
		print("Can't swipe there, that space is null right now"); 
	pass;
	
func checkIfRTSPieceFilled(chosen_selector):
	var cc = chosen_selector.myPiece.color; 
	if allColorsMatched.has(cc):
		return true;  
	return false; 

func partiallyFilledSelectors():
	for i in allSelectors:
		if checkIfRTSPieceFilled(i):
			i.dimMatchedPieces(true);
		else:
			i.dimMatchedPieces(false);
	pass;
		

#func touchDifference(gridpresspos, gridrelpos):
#	var dif = gridrelpos - gridpresspos; 
#	pass;

func create2DArray():
	var array = []
	for i in width:
		array.append([]); 
		for j in height:
			array[i].append(null); 
	
	allPieces = array; 
	return null; 

func convertGridToPixel(column, row):
	var x = x_start + offset * column; 
	var y = y_start -offset * row; 
	return Vector2(x, y); 

func convertGridToPixelSelector(row): 
	var y = selectory_start - selector_offset * row; 
	return Vector2(selectorx_start, y); 

func convertPixelToGrid(pixX, pixY):
	var x = .2 + (pixX - x_start)/offset; 
	var y = .2-(pixY - y_start)/offset; 
	if x > -0.5 and x < 0:
		x = 0;
	if x > width-1 and x < width-1 + .5:
		x = width-1
	if y < 0 and y > -0.5:
		y = 0; 
	if y < height-1 + .5 and y > height - 1:
		y = height - 1; 
	x = floor(x); 
	y = floor(y);
	return Vector2(x, y); 

func convertPixelToGridSelector(pixX, pixY):
	var selectory_offset = 30; 
	var horzbound = 450; 
	if pixX > horzbound:
		var y = -(pixY - selectory_start)/selector_offset;
		y = floor(y);
		return y
	return -1; 

func spawnPieces():
	for i in width:
		for j in height:
			var rand = floor(rand_range(0, possiblePieces.size()));
			var loops = 0; 
			var piece = possiblePieces[rand].instance(); 
			while(typeof(checkMatch(i, j, piece)) != 1 and loops < 100):
				rand = floor(rand_range(0, possiblePieces.size()));
				loops += 1; 
				piece = possiblePieces[rand].instance();
			add_child(piece); 
			piece.position = convertGridToPixel(i, j);
			allPieces[i][j] = piece;
			print(String(piece.position) + "is in position: " + String(i) + ", " + String(j)); 
			
func spawnSelectors():
	var selectors = []
	for i in possibleSelectors.size():
		var selectorPieceArray = []; 
		var selector = possibleSelectors[i].instance();
		get_parent().get_node("Selectors").add_child(selector);
		selector.addPiece(possiblePieces[i].instance());  
		selectorPieceArray.append(selector);  
		selectorPieceArray[0].position = convertGridToPixelSelector(i); 
		allSelectors += selectorPieceArray; 
	partiallyFilledSelectors();
	pass; 
	
func checkMatch(column, row, piece):
	var potentialArray = []; 
	if column > 1: 
		if allPieces[column-1][row] != null and allPieces[column-2][row] != null:
			if allPieces[column-1][row].color == piece.color and allPieces[column-2][row].color == piece.color:
				potentialArray += [allPieces[column][row], allPieces[column-1][row], allPieces[column-2][row]]; 
	if row > 1: 
		if allPieces[column][row-1] != null and allPieces[column][row-2] != null:
			if allPieces[column][row-1].color == piece.color and allPieces[column][row-2].color == piece.color:
				potentialArray += [allPieces[column][row], allPieces[column][row-1], allPieces[column][row-2]];  
	if potentialArray.size() > 0:
		return potentialArray
	else:
		return false;

func isPieceInGrid(column, row):
	#if touch isn't in grid, return false. 
	return column >= 0 && column < width && row >= 0 and row < height; 
	
func isPieceInSelector(row):
	return row >= 0 and row < height; 
			
func findMatches():
	#state = wait; 
	for i in width:
		for j in height:
			if allPieces[i][j] != null and allPieces[i][j].getMatched() == false:
				var checker = checkMatch(i, j, allPieces[i][j]);
				if typeof(checker) != 1:
					allColorsMatched.append(checker[0].color);
					for piece in checker:
						piece.dimMatchedPieces();
						piece.setMatched(true); 
	partiallyFilledSelectors(); 
	get_parent().get_node("destoryTimer").start();
	pass;			
	
func destroyMatchedPieces():
	for i in width:
		for j in height:
			if allPieces[i][j] != null and allPieces[i][j].getMatched() == true:
				allPieces[i][j].queue_free(); 
	pass;
				
func collapsedColumns():
	for i in width:
		for j in height:
			if allPieces[i][j] == null:
				for k in range(j + 1, height):
					if allPieces[i][k] != null:
						allPieces[i][k].move(convertGridToPixel(i, j)); 
						allPieces[i][j] = allPieces[i][k];
						allPieces[i][k] = null; 
						break;
	pass;
		
func refillColumns():
	for i in width:
		for j in height:
			if allPieces[i][j] == null:
				var rand = floor(rand_range(0, possiblePieces.size()));
				var loops = 0; 
				var piece = possiblePieces[rand].instance(); 
				while(typeof(checkMatch(i, j, piece)) != 1 and loops < 100):
					rand = floor(rand_range(0, possiblePieces.size()));
					loops += 1; 
					piece = possiblePieces[rand].instance();
				add_child(piece); 
				piece.position = convertGridToPixel(i, j + y_offset);
				piece.move(convertGridToPixel(i, j)); 
				allPieces[i][j] = piece; 


func addRTSPiece(piece):
	return piece.addRTSPiece(player);
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	#if state == move:
	#	touchInput(); 
	touchInput();
	pass; 


func _on_destoryTimer_timeout():
	destroyMatchedPieces();
	get_parent().get_node("destoryTimer").stop();
	get_parent().get_node("collapseTimer").start(); 
	pass # Replace with function body.
	
func _on_collapseTimer_timeout():
	collapsedColumns();
	get_parent().get_node("collapseTimer").stop();
	findMatches();  
	get_parent().get_node("refill").start();
	pass # Replace with function body.

func _on_refill_timeout():
	refillColumns(); 
	get_parent().get_node("refill").stop();
	#state = move; 
	pass # Replace with function body.
