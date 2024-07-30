extends Node

var save_path = "res://savegame.bin"

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var data: Dictionary = {
		"player_hp": Game.player_hp,
		"gold": Game.gold
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if FileAccess.file_exists(save_path):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.player_hp = current_line["player_hp"]
				if Game.player_hp <= 0:
					Game.player_hp = Game.total_player_hp
					Game.gold = 0
				else:
					Game.gold = current_line["gold"]
