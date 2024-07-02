extends Node2D

@export var owned = true
var occupied = false
var isHolding:Node

#controle de crescimento
var water = 0
var growth = 0

#informações da semente
var seedType:String
var fullyGrown:float = 10
var price:int
var color:Color

#sinais
signal planted
signal harvested
signal teste

func _ready():
	#prepara os vasos comprados
	visible = owned
	set_deferred("monitorable", owned)
	
	connect("teste", _on_teste)


func _process(_delta):
	#checa se o vaso está plantado e regado e faz a flor crescer
	if occupied and water > 0 and growth < fullyGrown:
		growing()
	elif growth < fullyGrown and fullyGrown - growth < 0.01:
		water += 0.01
#		growth = fullyGrown
#		growing()

#func _on_mouse_entered():
	if growth >= fullyGrown and growth > 0:
		$mouseover.mouse_default_cursor_shape = 2
	else:
		$mouseover.mouse_default_cursor_shape = 0
	
	$growthMeter.value = growth
	$waterMeter.value = water


func _on_area_entered(area):
	#verifica qual semente está sendo plantada
	#é melhor setar esse valor na loja quando o cursor segurar o objeto e salvar no isHolding e anular quando soltar
	isHolding = area.get_parent()

func _on_area_exited(area):
	isHolding = null


func setColor():
	match seedType:
		"daisy":
			color = (Color(1, 1, 1, 1))
		"buttercup":
			color = (Color(1, 1, 0.153))
		"tulip":
			color = (Color(0.255, 0.475, 1))
		"rose":
			color = (Color(0.882, 0.275, 0.259))
	$Root/Bud2.self_modulate = color
	$Root/Bud3.self_modulate = color
	$Root/Bud4.self_modulate = color


#planta uma flor no vaso
func plant():
	emit_signal("planted", isHolding)
	occupied = true
	$Occupied.visible = true
	fullyGrown = isHolding.fullyGrown
	$growthMeter.max_value = fullyGrown
	price = isHolding.price
	seedType = isHolding.seedType
	setColor()


#colhe a flor e reseta o vaso
func harvest():
	growth = 0
	occupied = false
	$Occupied.visible = false
	growthStage()
	emit_signal("harvested", price, seedType)


func growthStage():
#se possível, transformar em um match
#	match growth:

#método de revelação ascendente
#	if growth >= fullyGrown*1/4:
#		$Root/Growth1.visible = true
#	if growth >= fullyGrown*2/4:
#		$Root/Growth2.visible = true
#	if growth >= fullyGrown*3/4:
#		$Root/Growth3.visible = true
#	if growth >= fullyGrown:
#		$Root/Growth4.visible = true
#	else:
#		for child in $Root.get_children():
#			child.visible = false

#método de mudança de sprite
	if growth >= fullyGrown:
		$Root/Stalk.texture = load("res://Assets/Sprites/stage4-stalk.png")
		$Root/Bud3.visible = false
		$Root/Bud4.visible = true
	elif growth >= fullyGrown*3/4:
		$Root/Stalk.texture = load("res://Assets/Sprites/stage3-stalk.png")
		$Root/Bud2.visible = false
		$Root/Bud3.visible = true
	elif growth >= fullyGrown*2/4:
		$Root/Stalk.texture = load("res://Assets/Sprites/stage2-stalk.png")
		$Root/Bud2.visible = true
	elif growth >= fullyGrown*1/4:
		$Root/Stalk.texture = load("res://Assets/Sprites/stage1.png")
	else:
		$Root/Stalk.texture = null
		$Root/Bud4.visible = false


func _on_input_event(_viewport, _event, _shape_idx):
	#ao soltar a semente, checa se tem sementes e se o vaso está vazio antes de plantar
	if Input.is_action_just_released("click"):
		if isHolding == null:
			if growth >= fullyGrown:
				harvest()
		elif isHolding.is_in_group("seeds"):
			if not occupied and isHolding.has_seed():
				plant()
		#enche água
		elif isHolding.is_in_group("water"):
			water = 10.00
			emit_signal("teste")
	#crescimento instantâneo para debug
	elif Input.is_action_just_pressed("right_click"):
		if occupied:
			growth = fullyGrown
			growthStage()
#
func _on_teste():
#	$Water.start(10)
#	while($Water.time_left) and occupied:
#		$waterMeter.value = $Water.time_left
	pass 


func growing():
	water -= 0.0166
	growth += 0.0166

	#placeholder de estágio de crescimento
	growthStage()

	if visible:
		print('\n', "Water: ", water, '\n', "Growth: ", growth)
