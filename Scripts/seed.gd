extends Node2D

var dragging
@export var amount = 0
@onready var initial_position = position

#Variável pra determinar o sprite de cada semente
#não plantar quando tiver 0

func _ready():
#	connect("planted", _on_planted)
#	connect("check_seed_amount", checkSeedAmount)
	$Label.text = str(amount)


func _process(_delta):
	if dragging:
		position = get_global_mouse_position()


func _on_static_body_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		dragging = true
		print ("Te peguei")

	if Input.is_action_just_released("click"):
		position = initial_position
		dragging = false

#
#func _on_planted():
#	if amount>0:
#		amount-=1
#		$Control/Label.text = str(amount)
#		print(amount)
#
#func checkSeedAmount():
#	if amount>0:
#		return true
#	else:
#		return false
