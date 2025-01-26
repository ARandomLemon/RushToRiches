extends Control

#Properties
@export var card_name: String = "Base Card"
@export var modifier: String = "Base Modifier"
@export var texture_path: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Populate card
	$VBoxContainer/CardName.text = card_name
	$VBoxContainer/Modifier.text = modifier
	if $TextureRect:
		$TextureRect.texture = load(texture_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Card clickedP: %s" % card_name)
		Globals.card_array.append(card_name)
