extends Node2D
class_name Plant

@export var wellness: int = 80  
@export var growth_threshold: int = 60  
@export var soil_quality_multiplier: float = 1.0  
@export var growth_speed_modifier: float = 1.0  

@export var harvest_ready: bool = false
@export var growth_stages: int = 4
@export var water_tolerance: Vector2 = Vector2(0.3, 0.7)
@export var seed_yield: int = 2
@export var sunlight_level: float = 0.5
@export var disease_resistance: float = 0.8
@export var rarity: float = 0.1  

var index = 0
var last_water_time = 0.0  
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play(str(index))

# Función para modificar wellness
func modify_wellness(amount: int):
	wellness += amount
	wellness = clamp(wellness, 0, 100)  # Mantener wellness entre 0 y 100

# Función de riego con wellness y crecimiento
func water_plant():
	modify_wellness(10)  # Aumentamos el bienestar al regar
	
	# Esperar 5 segundos entre riegos para crecer
	if Time.get_ticks_msec() - last_water_time >= 5000 and wellness >= growth_threshold:
		grow()

	last_water_time = Time.get_ticks_msec()

# Función para avanzar la fase de crecimiento
func grow():
	if index < growth_stages - 1:
		index += 1
		animation_player.play(str(index))
	else:
		harvest_ready = true  
