extends Node2D
class_name Plant

@export var wellness: int = 80  # Nivel inicial de bienestar
@export var growth_threshold: int = 60  # Nivel mínimo para permitir el crecimiento
@export var soil_quality_multiplier: float = 1.0  # Valor base 1.0; menor acelera el tiempo
@export var growth_speed_modifier: float = 1.0  # Valor base 1.0; menor es más rápido

@export var harvest_ready: bool = false
@export var growth_stages: int = 4
@export var time_per_stage: float = 5.0
@export var water_tolerance: Vector2 = Vector2(0.3, 0.7)
@export var seed_yield: int = 2
@export var sunlight_level: float = 0.5
@export var disease_resistance: float = 0.8
@export var rarity: float = 0.1  # Probabilidad entre 0.0 (común) y 1.0 (extremadamente rara)

var index = 0

func _ready():
	$AnimationPlayer.play(str(index))
	$Timer.start(time_per_stage * soil_quality_multiplier * growth_speed_modifier)

func modify_wellness(points: int):
	wellness += points
	wellness = clamp(wellness, 0, 100)  # Limita el valor entre 0 y 100

func _on_timer_timeout():
	if index < growth_stages - 1 and wellness >= growth_threshold:
		index += 1
		$AnimationPlayer.play(str(index))
		$Timer.start(time_per_stage * soil_quality_multiplier * growth_speed_modifier)
	elif wellness < growth_threshold:
		print("Bienestar insuficiente para crecer.")
	else:
		harvest_ready = true
		$Timer.stop()
