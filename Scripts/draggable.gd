extends Node2D

var dragging
@export var reset_position = true
@onready var initial_position

func _process(_delta):
	if dragging:
		get_parent().position = get_global_mouse_position()

#controlador de drag n' drop
func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action("click") and Input.is_action_just_pressed("click"):
		initial_position = get_parent().position
		dragging = true
	if event.is_action("click") and Input.is_action_just_released("click"):
		if initial_position and reset_position:
			get_parent().position = initial_position
			dragging = false
