extends Node

var totalEarn: float
var propEarn:float
var stockEarn:float
var totalSum:float
var scale:float
var sigma

var prop_arr = [0,0,0]

@export var target_node: Node

var graphs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	graphs = get_node("Control2")
	
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
		propEarn += (2*prop_arr[0]) + (5*prop_arr[1]) + (10*prop_arr[2])
		stockEarn += 1
	
		totalEarn = propEarn + stockEarn
		
		totalSum = Globals.money + totalEarn
		increase_size()
		
		$TotalMoneyLabel.text = "Total Balance: $" + str(totalSum)
		$TotalEarnLabel.text = "Total Earnings: $" + str(totalEarn)
		$PropEarnLabel.text = "Property Earnings: $" + str(propEarn)
		$StockEarnLabel.text = "Stock Earnings: $" + str(stockEarn)
		$Timer/TimeLabel.text = "Time Left: " + str($Timer/Timer.time_left) + "s"		

		
		var elapsed_time = $Timer/Timer.wait_time-$Timer/Timer.time_left
		graphs.setNewPoint(elapsed_time, totalEarn)
	pass


var scalar :float = 0.05
func increase_size():
	scalar += 0.0004
	$Bubble.scale = Vector2(scalar,scalar)

func _on_timer_timeout() -> void:
	Globals.money = totalSum
	if(Globals.round_counter < 6):
		get_tree().change_scene_to_file("res://Scenes/party_phase.tscn")
		Globals.round_counter += 1
	else:
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
