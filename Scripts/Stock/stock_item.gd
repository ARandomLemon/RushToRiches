extends Container

var mouse_over: bool = false
@onready var hint = $Short/Hint
var s_name
var s_id
var s_share_count

func set_stock_item(id: String, share_cost: int, name: String, share_count: int, disable_button: bool = false) -> void:
	$Short.text = id + "\n" + str(share_cost) + "$"
	$Short/Hint/Long.text = name + "\n" + str(StockSystem.get_player_share_count(id)) + "/" + str(share_count)
	s_name = name
	s_id = id
	s_share_count = share_count
	if disable_button:
		$Button.disabled = true

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
