extends CharacterBody2D

var ball_offset = Vector2(0, -6.0)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Floor":
			velocity = Vector2.ZERO
			if collider.first_hit == false:
				collider.first_hit = true
				var new_pos = collision.get_position() + ball_offset
				collider.new_starting_position(new_pos)
			else:
				var tween = create_tween()
				tween.tween_property(self, "position", collider.get_ball_pos(), 0.3)
		else:
			velocity = velocity.bounce(collision.get_normal())
		
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
