extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Displays player variables upon loading scene - Tym
	_update_text()
	
	# Setting variables
	var building1 = get_node("Building1")
	var building2 = get_node("Building2")
	var building3 = get_node("Building3")
	var building4 = get_node("Building4")
	var building5 = get_node("Building5")
	var building6 = get_node("Building6")
	var building7 = get_node("Building7")
	var building8 = get_node("Building8")
	var building9 = get_node("Building9")
	var building10 = get_node("Building10")
	building1.id = 001
	building2.id = 002
	building3.id = 003
	building4.id = 004
	building5.id = 005
	building6.id = 006
	building7.id = 007
	building8.id = 008
	building9.id = 009
	building10.id = 010
	building1.exchange_building_info.connect(_on_exchange_building_info)
	building2.exchange_building_info.connect(_on_exchange_building_info)
	building3.exchange_building_info.connect(_on_exchange_building_info)
	building4.exchange_building_info.connect(_on_exchange_building_info)
	building5.exchange_building_info.connect(_on_exchange_building_info)
	building6.exchange_building_info.connect(_on_exchange_building_info)
	building7.exchange_building_info.connect(_on_exchange_building_info)
	building8.exchange_building_info.connect(_on_exchange_building_info)
	building9.exchange_building_info.connect(_on_exchange_building_info)
	building10.exchange_building_info.connect(_on_exchange_building_info)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_text():
	$UI/MoneyLabel.text = "Money: " + str(Globals.money)
	$UI/PropertyLabel.text = "Properties: " + str(Globals.property_array)
	$UI/CardLabel.text = "Cards: " + str(Globals.card_array)

func _on_exchange_building_info(id, category):
	print(id, (category))
	_update_text()
