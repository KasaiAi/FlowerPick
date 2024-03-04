extends Node2D

@export var owned = true
var occupied = false
var watered = false
var isHolding

var water = 0
var growth = 0

signal planted(seed)

func _ready():
	visible = owned
	set_deferred("monitorable", owned)


func _process(_delta):
	if occupied:# and watered:
		growing()


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
		elif isHolding.is_in_group("water"):
			water = 10.00
			watered = true

func growing():
	if water > 0:
#		set_paused = false
		water -= 0.017
		growth += 0.017
#		Timer.new()
		print("Water: ", water)
		print("Growth: ", growth)
	else:
#		set_paused = true
		watered = false

#	state machine for growth stages
#	timer for growing() function

