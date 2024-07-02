extends Node2D

var dragging
@export var reset_position:bool

@onready var initial_position

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", _on_static_body_2d_input_event)


func _process(_delta):
	if dragging:
		get_parent().position = get_global_mouse_position()


#controlador de drag n' drop
func _on_static_body_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		initial_position = get_parent().position
		dragging = true
		print ("Te peguei")
	if Input.is_action_just_released("click"):
		if reset_position:
			get_parent().position = initial_position
		dragging = false
