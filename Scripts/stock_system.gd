extends Node

@onready var inflation_rate: float = 0.5
@onready var purchased_stocks: Array = []

class Stock:
	var name = ""
	var id = ""
	var share_count = 100
	var share_cost = 5
	
	func _init(name, id, share_count, share_cost):
		self.name = name
		self.id = id
		self.share_count = share_count
		self.share_cost = share_cost
	
	func purchase_stock(amount) -> bool:
		if Globals.money < share_cost * amount:
			return false
		assert(share_count < amount, "Something went wrong... amount should never be > share_count.")
		share_count -= amount
		Globals.money -= share_cost * amount
		return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
