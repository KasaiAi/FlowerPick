extends Node2D

@export var owned = true
var occupied = false

signal planted
signal have_seed

func _ready():
	$Vase.visible = owned
	$Vase.monitoring = owned


func _process(_delta):
	pass


func _on_vase_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_released("click"):
		if emit_signal("check_seed_amount"):
			if not occupied:
				emit_signal("planted")
				occupied = true
				$Vase/Occupied.visible = true
				print ("Está plantada a margarida")
			else:
				print("não plantou")

#	if Input.is_action_just_released("click"):
#		if haveSeed() and not occupied:
#			emit_signal("planted")
#			occupied = true
#			$Vase/Occupied.visible = true
#			print ("Está plantada a margarida")
#		else:
#			print("não plantou")

func haveSeed():
	emit_signal("check_seed_amount")
