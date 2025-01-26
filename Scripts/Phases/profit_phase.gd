extends Node

var totalEarn: float
var propEarn:float
var stockEarn:float
var totalSum:float

var update_timer: float = 0.5

var prop_arr = [0,0,0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in Globals.owned_property.size():
		print(Globals.owned_property[i][0])
		
	for i in Globals.owned_property.size():
		match Globals.owned_property[i][1]:
			"residential": prop_arr[0] += 1
			"commercial": prop_arr[1] += 1
			"industry": prop_arr[2] += 1
			_:print("invalid category")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#run math as long as the timer is active
	if(!$Timer/Timer.is_stopped()):
		$TotalMoneyLabel.text = "Total Balance: $" + str(totalSum)
		$TotalEarnLabel.text = "Total Earnings: $" + str(totalEarn)
		$PropEarnLabel.text = "Property Earnings: $" + str(propEarn)
		$StockEarnLabel.text = "Stock Earnings: $" + str(stockEarn)

		$CardArrayLabel.text = "Cards:" + str(Globals.card_array)
		$Timer/TimeLabel.text = "Time Left: " + str($Timer/Timer.time_left) + "s"
		
		update_timer -= delta
		if (update_timer > 0):
			return
		update_timer = 0.5
		
		propEarn += (2*prop_arr[0]) + (5*prop_arr[1]) + (10*prop_arr[2])
		
		for s in StockSystem.stock_dict:
			StockSystem.stock_dict[s].advance_projection()
		for s in StockSystem.purchased_stocks_ids:
			stockEarn += (StockSystem.stock_dict[s].share_cost / 6) * StockSystem.purchased_stocks[s]
		
	
		totalEarn = propEarn + stockEarn
		
		totalSum = Globals.money + totalEarn
		
		

	pass

func _on_timer_timeout() -> void:
	Globals.money = totalSum
	if(Globals.round_counter < 6):
		get_tree().change_scene_to_file("res://Scenes/party_phase.tscn")
		Globals.round_counter += 1
	else:
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
