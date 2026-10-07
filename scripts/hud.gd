extends CanvasLayer

signal start_game

func _ready():
	$LevelIndicator.hide()
	$BallCounter.hide()
	$GameOver.hide()
	
func show_level():
	$LevelIndicator.show()

func _on_play_button_pressed() -> void:
	$PlayButton.hide()
	$MenuScreen.hide()
	start_game.emit()

func update_level(level):
	$LevelIndicator.text = "Level " + str(level)

func place_ball_count(pos):
	$BallCounter.position = pos + Vector2(-9, 6)
	$BallCounter.show()
	
func update_ball_count(num):
	if num == 0:
		$BallCounter.hide()
	$BallCounter.text = "x"+str(num)
	
func show_game_over():
	$GameOver.show()
	await get_tree().create_timer(3).timeout
	$GameOver.hide()
	$LevelIndicator.hide()
	$BallCounter.hide()
	$MenuScreen.show()
	$PlayButton.show()
