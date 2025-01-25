extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Displays player variables upon loading scene - Tym
	_update_text()
	
	# Setting variables
	var building1 = get_node("Building1")
	var building2 = get_node("Building2")
	building1.id = 001
	building2.id = 002
	building1.exchange_building_info.connect(_on_exchange_building_info)
	building2.exchange_building_info.connect(_on_exchange_building_info)
	Deck.create_card("test_test", "res://icon.sgv")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_text():
	$UI/MoneyLabel.text = "Money: " + str(Globals.money)
	$UI/PropertyLabel.text = "Properties: " + str(Globals.property_array)

func _on_exchange_building_info(id, category):
	print(id, (category))
	_update_text()
