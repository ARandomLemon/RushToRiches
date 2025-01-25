extends Node2D

var id = 000
var category = "retail"
var cost = 0
var dollarsPerSecond = 0
var purchased = false

signal exchange_building_info(id, category)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buy_button_pressed() -> void:
	if (purchased == false):
		print("wow")
		Globals.property_array.append(id)
		exchange_building_info.emit(id, category)
		purchased = true
	
	else:
		print("already bought!")
