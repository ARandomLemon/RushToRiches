extends Node

var stock_item_scene = preload("res://Scripts/Stock/stock_item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/property_phase.tscn")
	

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_buy_example_button_pressed() -> void:
	# Takes away money and adds "house" to player property array, also updates UI - Tym
	Globals.money = Globals.money - 100
	Globals.property_array.append("house")
	
	$MoneyLabel.text = "Money: " + str(Globals.money)
	$PropertyLabel.text = "Properties: " + str(Globals.property_array)


func _on_property_phase_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/property_phase.tscn")
	
func _on_stock_market_button_pressed() -> void:
	$StockMarket.visible = !$StockMarket.visible
	if($StockMarket.get_z_index() == 0):
		$StockMarket.set_z_index(1)
	else:
		$StockMarket.set_z_index(0)

func _on_stock_inventory_button_pressed() -> void:
	if not $StockInventory.visible: # we are opening in this case
		for purchase in StockSystem.purchased_stocks_ids:
			var item = stock_item_scene.instantiate()
			var stock = StockSystem.stock_dict[purchase]
			item.set_stock_item(stock.id, stock.share_cost, stock.name, stock.share_count, true)
			$StockInventory/GridContainer.add_child(item)
	else:
		for node in $StockInventory/GridContainer.get_children():
			$StockInventory/GridContainer.remove_child(node)
			node.queue_free()
	$StockInventory.visible = !$StockInventory.visible
	if($StockMarket.get_z_index() == 0):
		$StockInventory.set_z_index(1)
	else:
		$StockInventory.set_z_index(0)
