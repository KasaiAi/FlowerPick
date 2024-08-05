extends Node2D

@export var price: int
@export var maxAmount: int

signal purchased

func _ready():
	$Price.text = "$ "+ str(price)

func _process(_delta):
	pass

func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if Global.Money >= price:
			Global.Money -= price
			visible = false
			purchased.emit()
