extends Node

var totalEarn: float
var propEarn:float
var stockEarn:float
var totalSum:float



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#run math as long as the timer is active
	if(!$Timer/Timer.is_stopped()):
		propEarn += 1
		stockEarn += 1
	
		totalEarn = propEarn + stockEarn
		
		totalSum = Globals.money + totalEarn
		
		$TotalMoneyLabel.text = "Total Balance: $" + str(totalSum)
		$TotalEarnLabel.text = "Total Earnings: $" + str(totalEarn)
		$PropEarnLabel.text = "Property Earnings: $" + str(propEarn)
		$StockEarnLabel.text = "Stock Earnings: $" + str(stockEarn)
		$CardArrayLabel.text = "Cards:" + str(Globals.card_array)
		$Timer/TimeLabel.text = "Time Left: " + str($Timer/Timer.time_left) + "s"		
	pass

func _on_timer_timeout() -> void:
	Globals.money = totalSum
	get_tree().change_scene_to_file("res://Scenes/party_phase.tscn")
	pass # Replace with function body.
