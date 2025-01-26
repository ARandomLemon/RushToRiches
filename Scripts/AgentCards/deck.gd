extends Control

var card_scene: PackedScene = preload("res://Scripts/AgentCards/card.tscn")

func create_card(card_name : String):
	var grid_container = $GridContainer
	if not grid_container:
		print("GridContainer not found!") 
		return

	var card = card_scene.instantiate()
	card.card_name = card_name
	grid_container.add_child(card)

# Called when the node enters the scene tree for the first time.
func _ready():
	# test cards
	print($GridContainer)
	#create_card("test_1", "res://icon.svg")
	#create_card("test_2", "res://icon.svg")
	#create_card("test_3", "res://icon.svg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
