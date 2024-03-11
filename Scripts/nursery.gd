extends Node2D

var money = 0
var daisies = 0
var tulips = 0
var roses = 0
var buttercups = 0

func _ready():
	for child in $Vases.get_children():
		child.connect("planted", _on_planted)
		child.connect("harvested", _on_harvested)


func _process(_delta):
	pass


#func _on_planted():
#	$Seed1.amount-=1
#	$Seed1/Label.text = str($Seed1.amount)

func _on_planted(seed):
	seed.amount-=1
	seed.get_node("Label").text = str(seed.amount)


func _on_harvested(sellPrice, seedType):
	money += sellPrice
	$UI/money.text = "$ "+str(money)
	
	if seedType == "daisy":
		daisies += 1
		$UI/daisies.text = str(daisies)
	elif seedType == "buttercup":
		buttercups += 1
		$UI/buttercups.text = str(buttercups)
	elif seedType == "tulip":
		tulips += 1
		$UI/tulips.text = str(tulips)
	elif seedType == "rose":
		roses += 1
		$UI/roses.text = str(roses)
