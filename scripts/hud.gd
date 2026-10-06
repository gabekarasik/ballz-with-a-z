extends CanvasLayer


func update_level(level):
	$LevelIndicator.text = "Level " + str(level)

func place_ball_count(pos):
	$BallCounter.position = pos + Vector2(-9, 6)
	$BallCounter.show()
	
func update_ball_count(num):
	if num == 0:
		$BallCounter.hide()
	$BallCounter.text = "x"+str(num)
