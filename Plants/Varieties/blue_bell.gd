extends "res://Plants/base_plant.gd"

func _ready():
	seed_yield = 3  # Blue Bell produce más semillas
	growth_stages = 5  # Tiene más etapas de crecimiento
	water_tolerance = Vector2(0.4, 0.6)  # Necesita menos agua
	rarity = 0.2  # Rareza ajustada a un valor entre 0.0 y 1.0

	#Plant._ready()  # Llama explícitamente al método _ready() de la clase base
