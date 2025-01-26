extends Container

var mouse_over: bool = false
@onready var hint = $Short/Hint
var s_name
var s_id
var s_share_count
var s_share_cost

func set_stock_item(id: String, share_cost: int, name: String, share_count: int, sell_signal: bool = false) -> void:
	$Short.text = id + "\n" + str(share_cost) + "$"
	s_name = name
	s_id = id
	s_share_count = share_count
	s_share_cost = share_cost
	var connections = $Button.get_signal_connection_list("pressed")
	for conn in connections:
		$Button.disconnect("pressed", conn["callable"])
	if sell_signal:
		$Button.pressed.connect(sell_all_shares)
		$Short/Hint/Long.text = name + "\n" + str(StockSystem.get_player_share_count(id)) + "/" + str(share_count) + "\nClick to sell your shares!"
	else:
		$Button.pressed.connect(purchase_share)
		$Short/Hint/Long.text = name + "\n" + str(StockSystem.get_player_share_count(id)) + "/" + str(share_count)

func _process(delta: float):
	if (mouse_over):
		hint.position = get_local_mouse_position()

func _on_mouse_entered() -> void:
	hint.visible = true
	mouse_over = true

func _on_mouse_exited() -> void:
	hint.visible = false
	mouse_over = false

func purchase_share():
	if not StockSystem.stock_dict[$Short.text.split('\n')[0]].purchase_stock(1):
		return
	$Short/Hint/Long.text = s_name + "\n" + str(StockSystem.get_player_share_count(s_id)) + "/" + str(s_share_count)

func sell_all_shares():
	Globals.money += StockSystem.get_player_share_count(s_id) * s_share_cost
	StockSystem.purchased_stocks[s_id] = 0
	queue_free()
