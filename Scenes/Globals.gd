extends Node2D

var testGlobal = 15

var score = 0.0
var game_over = true

var current_mode = "Hard"
var current_color = "Green"

var projectile_limit = 0

var save_file_path = "user://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_file_path)

func _ready():
	pass 

func get_high_score(section, key):
	return config.get_value(section, key, 0)

func save_item(section, key, value):
	if score > config.get_value("HighScores", current_mode, 0):
		config.set_value("HighScores", current_mode, score)
		config.save(save_file_path)
		
func change_score(change):
	score += change
	
