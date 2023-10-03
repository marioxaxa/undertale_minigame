extends Container

var color := "white"
var tile_position = Vector2.ZERO

func _ready():
	match color:
		"rosa":
			self.modulate = Color8(255, 61, 113)
		"vermelho":
			self.modulate = Color8(204, 0, 0)
		"verde":
			self.modulate = Color8(24, 204, 0)
		"roxo":
			self.modulate = Color8(153, 0, 204)
		"amarelo":
			self.modulate = Color8(255, 207, 15)
		"azul":
			self.modulate = Color8(15, 123, 255)
		"laranja":
			self.modulate = Color8(255, 119, 15)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match color:
		"rosa":
			self.modulate = Color8(255, 61, 113)
		"vermelho":
			self.modulate = Color8(204, 0, 0)
		"verde":
			self.modulate = Color8(24, 204, 0)
		"roxo":
			self.modulate = Color8(153, 0, 204)
		"amarelo":
			self.modulate = Color8(255, 207, 15)
		"azul":
			self.modulate = Color8(15, 123, 255)
		"laranja":
			self.modulate = Color8(255, 119, 15)
		"white":
			pass
