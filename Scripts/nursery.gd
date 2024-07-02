extends Node2D

#var flowers = {
#	"daisies" = 0,
#	"buttercups" = 0,
#	"tulips" = 0,
#	"roses" = 0
#	}
#var seeds = {
#	"Seed1" = 3,
#	"Seed2" = 3,
#	"Seed3" = 3
#	}

var money = 0
var daisies = 0
var buttercups = 0
var tulips = 0
var roses = 0

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
#	seed.amount-=1
	seed.get_node("Label").text = str(seed.amount)


func _on_harvested(sellPrice, seedType):
	money += sellPrice
	$UI/money.text = "$ "+str(money)
	
	match seedType:
		"daisy":
			daisies += 1
			$UI/daisies.text = str(daisies)
		"buttercup":
			buttercups += 1
			$UI/buttercups.text = str(buttercups)
		"tulip":
			tulips += 1
			$UI/tulips.text = str(tulips)
		"rose":
			roses += 1
			$UI/roses.text = str(roses)
