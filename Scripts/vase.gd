extends Node2D

@export var owned = true
var occupied = false
var heldItem:Node

#controle de crescimento
var growthStage = 0
var teste = 4

#informações da semente
var seedType:String
var fullyGrown:float
var price:int
var color:Color

#sinais
signal planted
signal harvested

func _ready():
	#prepara os vasos comprados
	visible = owned
	set_deferred("monitorable", owned)
	
	$Growth.paused = true
	$Water.paused = true

func _process(_delta):
	spriteUpdate() # Seria legal se não precisasse atualizar todo frame, mas não achei uma solução mais confiável
	# Para debug
	#if visible:
	#	print('\n', "Water: ", $WaterMeter.value, '\n', "Growth: ", $GrowthMeter.value)
	
	$GrowthMeter.value = fullyGrown - $Growth.time_left
	$WaterMeter.value = $Water.time_left

func _on_area_entered(area):
	# Salva o objeto que está sendo segurado
	heldItem = area.get_parent()

func _on_area_exited(area):
	# Libera a variável
	heldItem = null
	if visible:
		print(heldItem)
		print(area)

# Atribui a cor de uma flor
func setColor():
	match seedType:
		"Daisy":
			color = (Color(1, 1, 1, 1))
		"Buttercup":
			color = (Color(1, 1, 0.153))
		"Tulip":
			color = (Color(0.255, 0.475, 1))
		"Rose":
			color = (Color(0.882, 0.275, 0.259))
	$Root/Bud2.self_modulate = color
	$Root/Bud3.self_modulate = color
	$Root/Bud4.self_modulate = color

# Planta e define as informações de uma flor
func plantVase(seed):
	# Reduzir sementes
	seed.updateAmount()
	# Mudar estado do vaso
	occupied = true
	$OccupiedIcon.visible = true
	# Importar dados da semente
	fullyGrown = seed.fullyGrown
	$GrowthMeter.max_value = fullyGrown
	price = seed.price
	seedType = seed.seedType
	setColor()
	# Atualizar timers
	$Growth.start(fullyGrown)
	$Water.paused = false
	if $Water.is_stopped() == false:
		$Growth.paused = false

# Rega o vaso
func waterVase():
	$Water.start(10)
	if occupied:
		$Water.paused = false
		$Growth.paused = false

# Colhe a flor e reseta o vaso
func harvestVase():
	$Growth.start(fullyGrown)
	occupied = false
	$OccupiedIcon.visible = false
	spriteUpdate()
	emit_signal("harvested", price, seedType)
	growthStage = 0
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_mouse_entered():
	# Muda o cursor quando a flor tá madura
	if growthStage == 4:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	# Reseta o cursor 
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

# Controlador do sprite da flor
func spriteUpdate():
	growthStage = floori($GrowthMeter.value/(fullyGrown/4))
	match growthStage:
		0:
			$Root/Stalk.texture = null
			$Root/Bud4.visible = false
		1:
			$Root/Stalk.texture = load("res://Assets/Sprites/stage1.png")
		2:
			$Root/Stalk.texture = load("res://Assets/Sprites/stage2-stalk.png")
			$Root/Bud2.visible = true
		3:
			$Root/Stalk.texture = load("res://Assets/Sprites/stage3-stalk.png")
			$Root/Bud2.visible = false
			$Root/Bud3.visible = true
		4:
			$Root/Stalk.texture = load("res://Assets/Sprites/stage4-stalk.png")
			$Root/Bud3.visible = false
			$Root/Bud4.visible = true

#Opções de input
func _on_input_event(_viewport, _event, _shape_idx):
	# Checks ao soltar a semente
	if Input.is_action_just_released("click"):
		# Se não tá segurando nada, colhe planta madura
		if heldItem == null:
			if growthStage == 4:
				harvestVase()
		# Se tá segurando uma semente e o vaso tá vazio, planta a semente
		elif heldItem.is_in_group("seeds"):
			if not occupied:
				plantVase(heldItem)
		# Se tá segurando água, rega o vaso
		elif heldItem.is_in_group("water"):
			waterVase()
	# Crescimento instantâneo para debug
	elif Input.is_action_just_pressed("right_click"):
		if occupied:
			$Growth.stop()
			pauseGrowth()
			spriteUpdate()
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func pauseGrowth():
	$GrowthMeter.value = fullyGrown - $Growth.time_left
	$Water.paused = true
	$Growth.paused = true
