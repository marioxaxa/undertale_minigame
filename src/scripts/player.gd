extends CharacterBody2D

@export var Tile_Size = 50

var LIVES = 3
var player_position = Vector2.ZERO

func _physics_process(delta):

	if Input.is_action_just_pressed("ui_right"):
		position.x += Tile_Size
		player_position[0] += 1
		do_ground()
	if Input.is_action_just_pressed("ui_left"):
		position.x -= Tile_Size
		player_position[0] += -1
		do_ground()
	if Input.is_action_just_pressed("ui_up"):
		position.y -= Tile_Size
		player_position[1] += -1
		do_ground()
	if Input.is_action_just_pressed("ui_down"):
		position.y += Tile_Size
		player_position[1] += 1
		do_ground()
	
	move_and_slide()

func do_ground():
	#var pivot_block = get_node("/root/" + str(player_position[0]) + "-" + str(player_position[1]))
	
	#print(get_tree().get_node("2-2"))
	
	if "pivot_block.color" == "amarelo":
		LIVES -= 1
		print(LIVES)
	
	
