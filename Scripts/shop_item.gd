extends Node2D

@export var price: int
@export var maxAmount: int
@export var itemType: String = ""
var seedType

func _ready():
	randomize()
	if itemType == "seed": # If item is a seed, choose a random seed type
		var picker = randi_range(1, 3)
		match picker:
			1:
				seedType = "Daisy"
				price = 1
				$Sprite2D.texture = load("res://Assets/Sprites/seed1.png")
			2:
				seedType = "Buttercup"
				price = 1
				$Sprite2D.texture = load("res://Assets/Sprites/seed2.png")
			3:
				seedType = "Tulip"
				price = 2
				$Sprite2D.texture = load("res://Assets/Sprites/seed3.png")
			4:
				seedType = "Rose"
	if itemType == "vase" and Global.Vases >=15:
		visible = false
	$Price.text = "$ "+ str(price)

func _process(_delta):
	pass

func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		if Global.Money >= price:
			Global.Money -= price
			visible = false
			Global.emit_signal("purchased")
			if itemType == "seed":
				Global.inventory[seedType]["Seeds"] += 1
			if itemType == "vase":
				Global.Vases += 1
