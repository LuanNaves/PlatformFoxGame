extends Node

var cherry = preload("res://scenes/cherry.tscn")

func _on_timer_timeout():
	var cherry_temp = cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	var rand_int = rng.randi_range(50, 1950)
	cherry_temp.position = Vector2(rand_int, 455)
	add_child(cherry_temp)
