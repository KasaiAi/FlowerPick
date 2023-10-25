extends Node2D

# Spot1.owned = Spot2.owned = true
# have a list of owned spots somewhere to set it here on startup
@export var seed1_amount = 5
@export var seed2_amount = 5
@export var seed3_amount = 5

func _ready():
	$Seed1.amount = seed1_amount


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
