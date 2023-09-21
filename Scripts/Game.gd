extends Node2D

onready var global = get_node("/root/Globals")

func _ready():
	pass

func _on_StartButton_pressed():
	get_node("UI/MenuButtons").move(Vector2(-576, 0))
	MoveStuff(0, -400, 0, 150, "Hard", false)
	global.game_over = false
	
func _on_BackButton_pressed():
	get_node("UI/MenuButtons").move(Vector2(0, 0))
	get_node("ScoreNode/EndOptions").move(Vector2(576, -40))
	MoveStuff(0, 100, 0, -400, "Hard", true)
	global.score = 0
	
func MoveStuff(ui_x, ui_y, score_x, score_y, mode, over):
	get_node("UI").move(Vector2(ui_x, ui_y))
	get_node("ScoreNode").move(Vector2(score_x, score_y))
	get_node("ScoreNode/HighScore").text = "High Score: " + str(global.get_high_score("HighScores", mode))
	global.current_mode = mode
	global.game_over = over

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_RestartButton_pressed():
	get_node("ScoreNode/EndOptions").move(Vector2(576, -40))
	global.score = 0
	global.game_over = false

func end_options():
	get_node("ScoreNode/EndOptions").move(Vector2(0, -40))

