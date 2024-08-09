extends Node2D

func _ready():
	var ownedVases = Global.Vases
	for child in $Vases.get_children():
		if ownedVases > 0:
			child.owned = true
			ownedVases -= 1
		child.visible = child.owned
		child.connect("harvested", _on_harvested)
	
	$UI/Money.text = "$ "+str(Global.Money)
	$UI/Daisy.text = str(Global.inventory["Daisy"]["Flowers"])
	$UI/Buttercup.text = str(Global.inventory["Buttercup"]["Flowers"])
	$UI/Tulip.text = str(Global.inventory["Tulip"]["Flowers"])
	$UI/Rose.text = str(Global.inventory["Rose"]["Flowers"])

func _on_harvested(sellPrice, seedType):
	Global.Money += sellPrice
	$UI/Money.text = "$ "+str(Global.Money)
	
	Global.inventory[seedType]["Flowers"] += 1
	$UI.get_node(seedType).text = str(Global.inventory[seedType]["Flowers"])
