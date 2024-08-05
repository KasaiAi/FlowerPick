extends Node2D


func _ready():
	connect("purchased", _on_purchased)
	$UI/Money.text = "$ "+str(Global.Money)
	$UI/Daisy.text = str(Global.inventory["Daisy"]["Flowers"])
	$UI/Buttercup.text = str(Global.inventory["Buttercup"]["Flowers"])
	$UI/Tulip.text = str(Global.inventory["Tulip"]["Flowers"])
	$UI/Rose.text = str(Global.inventory["Rose"]["Flowers"])

func _process(delta):
	pass

func _on_purchased():
	print("chegou?")
	$UI/Money.text = "$ "+str(Global.Money)
