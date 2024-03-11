extends Node2D

@export var owned = true
var occupied = false
var isHolding:Node

#controle de crescimento
var water = 0
var growth = 0

#informações da semente
var seedType:String
var fullyGrown:float
var price:int

#sinais
signal planted
signal harvested

func _ready():
	#prepara os vasos comprados
	visible = owned
	set_deferred("monitorable", owned)


func _process(_delta):
	#checa se o vaso está plantado e regado e faz a flor crescer
	if occupied and water > 0 and growth < fullyGrown:
		growing()
	elif growth < fullyGrown and fullyGrown - growth < 0.01:
		water += 0.01
#		growth = fullyGrown
#		growing()
	
	$growthMeter.value = growth
	$waterMeter.value = water



func _on_area_entered(area):
	#verifica qual semente está sendo plantada
	#é melhor setar esse valor na loja quando o cursor segurar o objeto, emitir para o _on_area_entered() e anular em seguida
	isHolding = area.get_parent()


func _on_area_exited(area):
	isHolding = null


func have_seed(seed):
	if seed.amount > 0:
		return true
  

func _on_input_event(_viewport, _event, _shape_idx):
	#ao soltar a semente, checa se tem sementes e se o vaso está vazio antes de plantar
	if Input.is_action_just_released("click"):
		if isHolding == null:
			return
		elif isHolding.is_in_group("seeds"):
			if not occupied and have_seed(isHolding):
				emit_signal("planted", isHolding)
				occupied = true
				$Occupied.visible = true
				fullyGrown = isHolding.fullyGrown
				$growthMeter.max_value = fullyGrown
				price = isHolding.price
				seedType = isHolding.seedType
		#enche água
		elif isHolding.is_in_group("water"):
			water = 10.00
	if Input.is_action_just_pressed("click"):
		#colhe a flor e reseta o vaso
		if growth >= fullyGrown:
			growth = 0
			occupied = false
			$Occupied.visible = false
			for child in $Root.get_children():
				child.visible = false
			emit_signal("harvested", price, seedType)


func growing():
	water -= 0.0166
	growth += 0.0166

	#placeholder de estágio de crescimento
	#substituir por uma mudança de sprite aqui e na colheita
	if growth >= fullyGrown/4:
		$Root/Growth1.visible = true
	if growth >= fullyGrown/2:
		$Root/Growth2.visible = true
	if growth >= fullyGrown/4*3:
		$Root/Growth3.visible = true
	if growth >= fullyGrown:
		$Root/Growth4.visible = true

	if visible:
		print('\n', "Water: ", water, '\n', "Growth: ", growth)

#	if not grows:
#		$GrowthCycle.start(5)
#		grows = true


#func _on_mouse_entered():
#	if growth >= fullyGrown:
#		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
#
#
#func _on_mouse_exited():
#	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
