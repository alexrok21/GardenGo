extends Node2D

@onready var sprite = $Sprite2D

func _ready():
	# Obtener el tamaño de la ventana
	var screen_size = get_viewport().get_visible_rect().size
	
	# Escalar el sprite para que ocupe toda la pantalla
	sprite.scale = screen_size / sprite.texture.get_size()
