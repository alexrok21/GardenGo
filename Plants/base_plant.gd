extends Node2D
class_name Plant

@export var harvest_ready: bool = false

var index = 0

func _ready():
	$AnimationPlayer.play(str(index))
	$Timer.start()  # Asegúrate de que el timer comience al iniciar la escena
	$HarvestButton.visible = false  # Asegúrate de que el botón de cosecha esté oculto inicialmente

func _on_timer_timeout():
	if index < 3:
		index += 1
		$AnimationPlayer.play(str(index))
	else:
		harvest_ready = true
		$Timer.stop()  # Detenemos el timer al final del ciclo
		$HarvestButton.visible = true  # Mostramos el botón "Cosechar" cuando la planta está lista
