extends Node2D

var time_limit = 3
var current_time = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	$TimerLabel.text = "Time Left: " + str(current_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# timer times out every 1 second, to get more accurate time counter - Tym
func _on_timer_timeout() -> void:
	current_time = current_time - 1
	if (current_time == 0):
			current_time = 30
			get_tree().change_scene_to_file("res://Scenes/party_phase.tscn")
	$TimerLabel.text = "Time Left: " + str(current_time)
	$Timer.start()
