extends Node2D

# Spot1.owned = Spot2.owned = true
# have a list of owned spots somewhere to set it here on startup

func _ready():
	for child in $Vases.get_children():
		child.connect("planted", _on_planted)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_planted():
	$Seed1.amount-=1
	$Seed1/Label.text = str($Seed1.amount)
#	seed.amount-=1
#	seed./Control/Label.text = str($Seed1.amount)
