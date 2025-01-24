extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Displays player variables upon loading scene - Tym
	$UI/MoneyLabel.text = "Money: " + str(Globals.money)
	$UI/PropertyLabel.text = "Properties: " + str(Globals.property_array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
