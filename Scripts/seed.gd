extends Node2D

var dragging
@export var amount = 0
@onready var initial_position = position

#@export_flags("Fire", "Water", "Earth", "Wind") var spell_elements = 0


#Variável pra determinar o sprite de cada semente (seedType)

func _ready():
#	connect("planted", _on_planted)
#	connect("check_seed_amount", checkSeedAmount)
	$Label.text = str(amount)


func _process(_delta):
	if dragging:
		position = get_global_mouse_position()

#controlador de drag n' drop
func _on_static_body_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		dragging = true
		print ("Te peguei")

	if Input.is_action_just_released("click"):
		position = initial_position
		dragging = false

#func _on_planted():
#	if amount>0:
#		amount-=1
#		$Control/Label.text = str(amount)
