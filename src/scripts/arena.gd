extends Node2D


@export var Tile_Size = 50
@export var Board_Size = 5

func _ready():
	randomize()
	
	#This is the tile where the player starts
	var inicial_tile = $inicial_tile
	
	#Top left tile position
	var pivot_position = Vector2(inicial_tile.global_position[0] - (Board_Size * Tile_Size), inicial_tile.global_position[1] + (Board_Size * Tile_Size))

	var tile_scene = preload("res://src/scenes/base_tile.tscn")
	
	for Y_Cord in range(-Board_Size,Board_Size+1):
		for X_Cord in range(-Board_Size,Board_Size+1):
			var temp = tile_scene.instantiate()
			temp.set_name(str(X_Cord) + "-" + str(Y_Cord))
			temp.global_position = Vector2(inicial_tile.global_position[0] - (X_Cord * Tile_Size), inicial_tile.global_position[1] + (Y_Cord * Tile_Size))
			temp.tile_position = Vector2(X_Cord,Y_Cord)
			add_child(temp)
			
	var win_route = generate_win_route()
	
	#Generatin borders e center block
	for board in range(-Board_Size,Board_Size+1):
		var pivot_block_down = get_node(str(board) + "-" + str(Board_Size))
		pivot_block_down.color = "branco"
		var pivot_block_up = get_node(str(board) + "-" + str(-Board_Size))
		pivot_block_up.color = "branco"
		var pivot_block_left = get_node(str(-Board_Size) + "-" + str(board))
		pivot_block_left.color = "branco"
		var pivot_block_right = get_node(str(Board_Size) + "-" + str(board))
		pivot_block_right.color = "branco"
	
	var possible_colors_to_win = ["rosa","verde","azul","roxo","laranja"]
	var last_color = "branco"
	var color_route = ["branco"]
	for coord_index in win_route.size():
		var pivot_block = get_node(str(win_route[coord_index][0]) + "-" + str(win_route[coord_index][1]))
		var possible_colors_HOLDER = possible_colors_to_win.duplicate()
		
		if coord_index > 0 and coord_index < win_route.size() - 1:
			#Condition to prevent orange before blue
			var is_water_dangerous = false
			for color in color_route:
				if color == "roxo":
					is_water_dangerous = false
				elif color == "laranja":
					is_water_dangerous = true
			if is_water_dangerous:
				possible_colors_HOLDER.erase("azul")
			
			#Condition to prevent purples in the corners
			var is_straight_x = false
			var is_straight_y = false
			if (win_route[coord_index-1][0] == win_route[coord_index][0] and win_route[coord_index][0] == win_route[coord_index+1][0]):
				is_straight_x = true
				pass
			if (win_route[coord_index-1][1] == win_route[coord_index][1] and win_route[coord_index][1] == win_route[coord_index+1][1]):
				is_straight_y = true
			if !(is_straight_x or is_straight_y):
				possible_colors_HOLDER.erase("roxo")
			

			pivot_block.color = possible_colors_HOLDER.pick_random()
		else:
			pivot_block.color = "branco"

		last_color = pivot_block.color
		color_route.push_back(pivot_block.color)
		
	
	var possible_neighboor_colors = ["rosa","verde","azul","roxo","laranja","amarelo","vermelho"]
	for coord_index in win_route.size() -1:
		var pivot_block = get_node(str(win_route[coord_index][0]) + "-" + str(win_route[coord_index][1]))
		var possible_neighboor_colors_HOLDER = possible_neighboor_colors.duplicate()
		
		if pivot_block.color == "azul":
				possible_neighboor_colors_HOLDER.erase("amarelo")

		var down_neighboor = get_node(str(win_route[coord_index][0]) + "-" + str(win_route[coord_index][1]+1))
		if down_neighboor.color == null:
			down_neighboor.color = possible_neighboor_colors_HOLDER.pick_random()
		var up_neighboor = get_node(str(win_route[coord_index][0]) + "-" + str(win_route[coord_index][1]-1))
		if up_neighboor.color == null:
			up_neighboor.color = possible_neighboor_colors_HOLDER.pick_random()
		var right_neighboor = get_node(str(win_route[coord_index][0]+1) + "-" + str(win_route[coord_index][1]))
		if right_neighboor.color == null:
			right_neighboor.color = possible_neighboor_colors_HOLDER.pick_random()
		var left_neighboor = get_node(str(win_route[coord_index][0]-1) + "-" + str(win_route[coord_index][1]))
		if left_neighboor.color == null:
			left_neighboor.color = possible_neighboor_colors_HOLDER.pick_random()
	
	for Y_Cord in range(-Board_Size,Board_Size+1):
		for X_Cord in range(-Board_Size,Board_Size+1):
			var pivot_block = get_node(str(X_Cord) + "-" + str(Y_Cord))
			if pivot_block.color == null:
				pivot_block.color = possible_neighboor_colors.pick_random()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_win_route():
	
	#Win route is gonna have all the coordinates that let the player win
	var win_route = [Vector2.ZERO]
	
	#Visited route is gonna be all the coordinates in wich the pivot vectior has already passed
	var visited_route = [Vector2.ZERO]
	
	var pivot_vector = Vector2.ZERO
	
	#This loop is gonna keep going until the pivot vector is in a border
	while (pivot_vector.x < Board_Size and pivot_vector.x > -Board_Size) and (pivot_vector.y < Board_Size and pivot_vector.y > -Board_Size):
		var possible_directions = ["up","down","left","right"]
		#This loop is responsible for getting a random direction that was not visited and storing in the pivot_vector
		while pivot_vector == win_route[win_route.size()-1]:
	
			if possible_directions.is_empty():
				visited_route.push_back(pivot_vector)
				pivot_vector = win_route.pop_back()
				possible_directions = ["up","down","left","right"]
			
			#Getting a random direction
			var direction = possible_directions.pick_random()
			if direction == "up":
				pivot_vector += Vector2.UP
			if direction == "right":
				pivot_vector += Vector2.RIGHT
			if direction == "down":
				pivot_vector += Vector2.DOWN
			if direction == "left":
				pivot_vector += Vector2.LEFT
			
			
			if visited_route.has(pivot_vector):
				pivot_vector = win_route[win_route.size()-1]
				possible_directions.erase(direction)
		
		win_route.push_back(pivot_vector)
		visited_route.push_back(pivot_vector)
		
	return win_route
	
	
