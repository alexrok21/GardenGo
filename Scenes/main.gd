extends Node2D

var currentSeed = preload("res://Plants/Varieties/blue_bell.tscn")  # Ruta a la escena Blue Bell

@onready var plant_node = $Background/Plant  # Referencia al nodo vacío para la planta
@onready var planting_button = $PlantingButton  # Referencia al botón de plantar
@onready var harvest_button = $HarvestButton  # Referencia al botón de cosechar
@onready var watering_button = $WaterButton  # Referencia al botón de regar
@onready var water_effect = $Background/Watering/WaterDrop  # Referencia al efecto de riego

var current_plant  # Variable para almacenar la instancia actual de la planta

func plant_seed():
	if plant_node.get_child_count() > 0:
		plant_node.get_child(0).queue_free()  # Elimina cualquier planta anterior
	
	current_plant = currentSeed.instantiate()  # Crea una instancia de la planta
	plant_node.add_child(current_plant)  # Agrega la planta al nodo Plant
	
	var sprite = $Background/Sprite2D
	var center_position = sprite.texture.get_size() / 2
	current_plant.position = center_position  # Posiciona la planta en el centro
	
	# Mostrar los atributos de la planta actual
	print("BlueBell Attributes:")
	print("Seed yield:", current_plant.seed_yield)
	print("Growth stages:", current_plant.growth_stages)
	print("Water tolerance:", current_plant.water_tolerance)
	print("Rarity:", current_plant.rarity)

func _on_planting_button_pressed():
	plant_seed()  # Llama a la función que instancia la planta
	planting_button.visible = false  # Oculta el botón de plantar
	harvest_button.visible = false  # Asegura que el botón de cosechar esté oculto
	watering_button.visible = true  # Muestra el botón de regar

func _on_harvest_button_pressed():
	if current_plant:
		current_plant.queue_free()  # Elimina la planta actual
		current_plant = null  # Limpia la referencia a la planta
	planting_button.visible = true  # Muestra el botón "Plantar"
	harvest_button.visible = false  # Oculta el botón "Cosechar"
	watering_button.visible = false  # Oculta el botón de regar

# Función para manejar cuando el botón de regar es presionado
func _on_water_button_pressed():
	if current_plant:
		watering_button.disabled = true  
		current_plant.water_plant()  # Usa la nueva lógica de riego
		_show_water_effect()

# Función para mostrar la animación de la gota de agua y esperar 5 segundos
func _show_water_effect():
	water_effect.visible = true  # Hace visible la animación
	water_effect.play("watering_plant")  # Inicia la animación

	# Crea un temporizador para ocultar la animación después de 5 segundos
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.timeout.connect(_on_water_effect_timeout)  # Conecta la señal correctamente
	timer.start()

# Función para manejar cuando el temporizador se agota
func _on_water_effect_timeout():
	water_effect.stop()  # Detiene la animación
	water_effect.visible = false  # Oculta la animación
	watering_button.disabled = false  # Reactiva el botón de regar

func _process(_delta):
	# Verifica si la planta ha terminado su ciclo de crecimiento
	if current_plant and current_plant.harvest_ready:
		harvest_button.visible = true  # Muestra el botón "Cosechar"
