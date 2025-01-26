extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Deck.create_card("test_1")
	$UI/AnimationPlayer.play("sigma")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
