extends Node

var frog = preload("res://scenes/frog.tscn")

func _on_timer_timeout():
	var frog_temp = frog.instantiate()
	var rng = RandomNumberGenerator.new()
	var rand_int = rng.randi_range(200, 1950)
	frog_temp.position = Vector2(rand_int, 455)
	add_child(frog_temp)

