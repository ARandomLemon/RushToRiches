extends Control

@export var card_scene: PackedScene = preload("res://Scenes/card.tscn")

func create_card(card_name : String, texture_path: String):
	var grid_container = get_node("GridContainer")
	if not grid_container:
		print("GridContainer not found!") 
		return

	var card = card_scene.instantiate()
	card.card_name = card_name
	card.texture_path = texture_path
	grid_container.add_child(card)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# test cards
	print(get_node("GridContainer"))
	create_card("test_1", "res://icon.svg")
	create_card("test_2", "res://icon.svg")
	create_card("test_3", "res://icon.svg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
