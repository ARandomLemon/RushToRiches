extends Node

@onready var money = 10000
@onready var property_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
@onready var propList =[]

@onready var num_property_owned = 0
@onready var owned_property = []

@onready var card_array = ["test"]

@onready var round_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resetGame() -> void:
	money = 10000
	property_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	propList.clear()
	num_property_owned = 0
	owned_property.clear()
	round_counter = 0
	
	card_array = ["test"]
