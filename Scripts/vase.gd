extends Node2D

@export var owned = true
var occupied = false
var rememberSeed

signal planted

func _ready():
	visible = owned
	set_deferred("monitorable", owned)


func _process(_delta):
	pass


func _on_area_entered(area):
	rememberSeed = area.get_parent()


func have_seed(seed):
	if seed.amount > 0:
		return true


func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_released("click"):
		if not occupied and have_seed(rememberSeed):
			emit_signal("planted")
			occupied = true
			$Occupied.visible = true
			print ("Está plantada a margarida")
		else:
			print("não plantou")


#if release click on collision:
#	if not occupied and seeds<0:
#		occupied = true
#		$Vase/Occupied.visible = true
#		print ("Está plantada a margarida")
#	else:
#		print("não plantou")

#send a signal to the shop to execute function
#check seed amount, check occupation, plant and subtract seed
