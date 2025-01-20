extends Node2D
class_name Plant

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
	$Timer.start()

func _on_timer_timeout():
	if index < growth_stages - 1:
		index += 1
		$AnimationPlayer.play(str(index))
	else:
		harvest_ready = true
		$Timer.stop()
