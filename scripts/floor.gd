extends StaticBody2D

signal ball_landed

var first_hit = false
var ball_pos = Vector2()

func hit():
	ball_landed.emit()

func new_starting_position(ball_position):
	ball_pos = ball_position
	get_parent().ball_position = ball_position
		
func get_ball_pos():
	return ball_pos
