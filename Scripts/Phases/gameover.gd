extends Node

#USE THESE VARIABLES TO DISPLAY INFORMATION ONLY
var money: float = Globals.money
var num_property_owned: int = Globals.num_property_owned
var owned_property = Globals.owned_property
var card_array = ["test"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TotalEarnedLabel.text = "Money You Had before it all became useless: $" + str(money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	Globals.resetGame()
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
