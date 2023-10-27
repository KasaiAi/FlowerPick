extends Node2D


func _ready():
	for child in $Vases.get_children():
		child.connect("planted", _on_planted)


func _process(_delta):
	pass


#func _on_planted():
#	$Seed1.amount-=1
#	$Seed1/Label.text = str($Seed1.amount)

func _on_planted(seed):
	seed.amount-=1
	seed.get_node("Label").text = str(seed.amount)
