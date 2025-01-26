extends Node2D

var id = 000
var category = "retail"
var cost = 0
var dollarsPerSecond = 0
var isOwned: bool = false

signal exchange_building_info(id, category)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buy_button_pressed() -> void:
	for i in 10:
		if (Globals.property_array[i] == id ):
			print("already bought!")
			break
		if (Globals.property_array[i] == 0 && Globals.money>=cost):
			Globals.property_array[i] = id
			exchange_building_info.emit(id, category)
			isOwned = true
			Globals.num_property_owned += 1
			Globals.money -= cost
			break
		elif(Globals.property_array[i] == 0 && Globals.money<=cost): 
			print("You're poor. Get your money up not your funny up")
			break
