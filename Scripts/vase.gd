extends Node2D

@export var owned = true
var occupied = false
var isHolding = self

var water = 0
var growth = 0

@export var fully_grown = 20

signal planted(seed)

func _ready():
	visible = owned
	set_deferred("monitorable", owned)


func _process(_delta):
	#checa se o vaso está plantado e regado e faz a flor crescer
	if occupied and water > 0 and growth < fully_grown:
		growing()
	elif growth < fully_grown and fully_grown - growth < 0.01:
		water += 0.01
#		growth = fully_grown
#		growing()
	
	$growthMeter.value = growth
	$waterMeter.value = water
	
	if visible:
		print()
		print("Water: ", water)
		print("Growth: ", growth)


func _on_area_entered(area):
	#verifica qual semente está sendo plantada
	#é melhor setar esse valor na loja quando o cursor segurar o objeto, emitir para o _on_area_entered() e anular em seguida
	isHolding = area.get_parent()


func have_seed(seed):
	if seed.amount > 0:
		return true
  

func _on_input_event(_viewport, _event, _shape_idx):
	#ao soltar a semente, checa se tem sementes e se o vaso está vazio antes de plantar
	if Input.is_action_just_released("click"):
		if isHolding.is_in_group("seeds"):
			if not occupied and have_seed(isHolding):
				emit_signal("planted", isHolding)
				occupied = true
				$Occupied.visible = true
				$growthMeter.max_value = fully_grown
#				fully_grown = isHolding.fully_grown
		if isHolding.is_in_group("water"):
			#enche água
			water = 10.00
		isHolding = self
	if Input.is_action_just_pressed("click"):
		if growth >= fully_grown:
#			harvest()
			#colhe a flor e reseta o vaso
			growth = 0
			occupied = false
			$Occupied.visible = false
			for child in $Root.get_children():
				child.visible = false


func growing():
	water -= 0.0166
	growth += 0.0166

	#placeholder de estágio de crescimento
	#substituir por uma mudança de sprite aqui e na colheita
	if growth >= fully_grown/4:
		$Root/Growth1.visible = true
	if growth >= fully_grown/2:
		$Root/Growth2.visible = true
	if growth >= fully_grown/4*3:
		$Root/Growth3.visible = true
	if growth >= fully_grown:
		$Root/Growth4.visible = true

#	if not grows:
#		$GrowthCycle.start(5)
#		grows = true
