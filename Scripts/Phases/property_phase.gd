extends Node2D

var ownedProp=[]
var propList=[]
var isFirstRun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Displays player variables upon loading scene - Tym
	_update_text()

	# Setting variables
	#for loop to set the different buildings
	for building in 10:
		var node_text:String = "Building" + str((building + 1))
		propList.append(get_node(node_text))
		propList[building].id = building + 1
		propList[building].exchange_building_info.connect(_on_exchange_building_info)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _update_text():
	$UI/MoneyLabel.text = "Money: " + str(Globals.money)
	$UI/PropertyLabel.text = "Properties: " + str(Globals.property_array)

func _on_exchange_building_info(id, category):
	print(id, (category))
	_update_text()


func _on_profit_phase_button_pressed() -> void:
	for i in Globals.num_property_owned:
		Globals.owned_property.append([null,null,null,null,null])
	
	var i :int = 0
	for b in 10:
		if(propList[b].isOwned):
			#for i in 5:
			Globals.owned_property[i][0] = propList[b].id
			Globals.owned_property[i][1] = propList[b].category
			Globals.owned_property[i][2] = propList[b].cost
			Globals.owned_property[i][3] = propList[b].dollarsPerSecond
			Globals.owned_property[i][4] = propList[b].isOwned
			i+=1
	
	get_tree().change_scene_to_file("res://Scenes/profit_phase.tscn")
