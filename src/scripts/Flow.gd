extends FlowContainer

@export var Board_X_Size = 8
@export var Board_Y_Size = 8

@export var Tile_X_Size: int = 50
@export var Tile_Y_Size: int = 50

const Tile_Colors : PackedStringArray = ["rosa","vermelho","roxo","azul","amarelo","laranja","verde"]

func _ready():
	
	var tile_scene = preload("res://src/scenes/tile.tscn")
	
	# Generate board size
	if Board_X_Size < 0 || Board_Y_Size < 0:
		return
	var Number_X = 0
	var Number_Y = 0
	# Set up the board
	while Number_Y != Board_Y_Size:
		self.size.y += Tile_Y_Size 
		self.size.x += Tile_X_Size 
		while Number_X != Board_X_Size:
			var temp = tile_scene.instantiate()
			temp.set_custom_minimum_size(Vector2(Tile_X_Size, Tile_Y_Size))

			
			#temp.connect("pressed", func():
				#emit_signal("send_location", temp.name))
			temp.set_name(str(Number_X) + "-" + str(Number_Y))
			add_child(temp)
			Number_X += 1
		Number_Y += 1
		Number_X = 0
	Create_Board()


func Create_Board():
	randomize()
	var Step = 0
	
	while Step < Board_X_Size * Board_Y_Size:
		var color_index = randi_range(0,6)
		var temp = $".".get_child(Step)
		temp.color = Tile_Colors[color_index]
		temp.position = Vector2(Tile_X_Size / 2, Tile_Y_Size / 2)
		Step += 1
		
	var test = $".".get_children()
	print(test)

func _process(delta):
	pass
