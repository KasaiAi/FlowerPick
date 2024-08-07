extends Node2D

var dragging
@export var amount = 0
@export var seedType:String = ""
@export var fullyGrown = 20
@export var price = 1

@onready var initial_position = position

#@export_flags("Fire", "Water", "Earth", "Wind") var spell_elements = 0

func _ready():
	amount = Global.inventory[seedType]["Seeds"]
	if amount == 0:
		queue_free()
	$Amount.text = str(amount)

func _process(_delta):
	pass

func updateAmount():
	amount -= 1
	$Amount.text = str(amount)
	Global.inventory[seedType]["Seeds"] = amount
	if amount == 0:
		queue_free()
