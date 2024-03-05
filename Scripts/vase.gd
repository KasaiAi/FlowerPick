extends Node2D

@export var owned = true
var occupied = false
var isHolding

var water = 0
var growth = 0

var grows = false

signal planted(seed)

func _ready():
	visible = owned
	set_deferred("monitorable", owned)


func _process(_delta):
	if occupied and water > 0:
		growing()
	
	if water <= 0:
		$GrowthCycle.set_paused(true)
	else:
		$GrowthCycle.set_paused(false)
	
	$growth.value = growth
	$water.value = water
	
	if visible:
		print("Water: ", water)
		print("Growth: ", growth)
		print($GrowthCycle.time_left)
	
	if growth > 5:
		$Root/Growth1.visible = true
	if growth > 10:
		$Root/Growth2.visible = true
	if growth > 15:
		$Root/Growth3.visible = true
	if growth > 20:
		$Root/Growth4.visible = true

func _on_area_entered(area):
	#verifica qual semente está sendo plantada
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
				print ("Está plantada a margarida")
			else:
				print("não plantou")
		if isHolding.is_in_group("water"):
			water = 10.00
			print("Water: ", water)
			print("Growth: ", growth)

func growing():
#	GrowthCycle
#	se chegar no fim, aumenta um estágio de crescimento
#		stage +1
#		grows = false

	if not grows:
		$GrowthCycle.start(5)
		grows = true
	water -= 0.0166
	growth += 0.0166


#	state machine for growth stages
#	timer to replace growing() function


func _on_growth_cycle_timeout():
#	growth_stage += 1
#	grows = false
	pass # Replace with function body.
