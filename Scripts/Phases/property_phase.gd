extends Node2D

var ownedProp=[]
var propList=[]
var isFirstRun
var stock_item_scene = preload("res://Scripts/Stock/stock_item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Displays player variables upon loading scene - Tym
	_update_text()
	$UI/AnimationPlayer.play("buttons_enter")
	# Setting variables
	#for loop to set the different buildings
	for b in 10:
		var node_text:String = "Building" + str((b + 1))
		propList.append(get_node(node_text))
		propList[b].id = b + 1
		propList[b].exchange_building_info.connect(_on_exchange_building_info)
		
		match propList[b].id:
			1:	propList[b].category = "residential"
			2:	propList[b].category = "commercial"
			3:	propList[b].category = "commercial"
			4:	propList[b].category = "residential"
			5:	propList[b].category = "residential"
			6:	propList[b].category = "commercial"
			7:	propList[b].category = "residential"
			8:	propList[b].category = "residential"
			9:	propList[b].category = "industry"
			10:	propList[b].category = "industry"
			_: print("invalid ID")
		
		match propList[b].category:
			"residential":
				propList[b].cost = 25000
				propList[b].dollarsPerSecond = 2
			"commercial":
				propList[b].cost = 100000
				propList[b].dollarsPerSecond = 5
			"industry":
				propList[b].cost = 500000
				propList[b].dollarsPerSecond = 10
			_: print("Invalid category")
		
		for i in Globals.owned_property.size():
			if(Globals.owned_property[i][0] == propList[b].id):
				propList[b].isOwned = true
				
		#print("id: " + str(propList[b].id))
		#print("cat: " + str(propList[b].category))
		#print("cost: " + str(propList[b].cost))
		#print("dps: " + str(propList[b].dollarsPerSecond))
		#print("isOwned: " + str(propList[b].isOwned))
	# Load this round's 3x3 for the stocks
	var tbt = StockSystem.get_3x3_stock()
	for stock in tbt:
		var item = stock_item_scene.instantiate()
		item.set_stock_item(stock.id, stock.share_cost, stock.name, stock.share_count)
		$UI/StockMarket/GridContainer.add_child(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$UI/MoneyLabel.text = "Money: " + str(Globals.money)


func _update_text():
	$UI/MoneyLabel.text = "Money: " + str(Globals.money)
	$UI/PropertyLabel.text = "Properties: " + str(Globals.property_array)

func _on_exchange_building_info(id, category):
	print(id, (category))
	_update_text()


func _on_profit_phase_button_pressed() -> void:
	Globals.owned_property.clear()
	
	for i in Globals.num_property_owned:
		Globals.owned_property.append([null,null,null,null,null])
	
	var i :int = 0
	for b in 10:
		#print(propList[b].isOwned)
		if(propList[b].isOwned):
			Globals.owned_property[i][0] = propList[b].id
			Globals.owned_property[i][1] = propList[b].category
			Globals.owned_property[i][2] = propList[b].cost
			Globals.owned_property[i][3] = propList[b].dollarsPerSecond
			Globals.owned_property[i][4] = propList[b].isOwned
			i += 1
	
	get_tree().change_scene_to_file("res://Scenes/profit_phase.tscn")
