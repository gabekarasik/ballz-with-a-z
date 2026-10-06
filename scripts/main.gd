extends Node2D

@export var brick_scene: PackedScene
@export var ball_scene: PackedScene
@export var powerup_scene: PackedScene

var positions = Array()
var balls = Array()
var num_balls = 0
var in_motion = 0
var ball_speed = 600.0
var ball_position = Vector2()
var level = 1
var new_balls = 0
var brick_offset = Vector2(67.0, 67.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.update_level(level)
	ball_position = $StartPosition.position
	var ball = ball_scene.instantiate()
	ball.position = ball_position
	balls.append(ball)
	num_balls += 1
	add_child(ball)
	$HUD.place_ball_count(ball_position)
	$HUD.update_ball_count(num_balls)
	create_pos_array()
	place_bricks()
	move_bricks()

func _input(event):
	if event.is_action_released("shoot"):
		var cursor_position = get_global_mouse_position()
		var direction = (cursor_position - ball_position).normalized()
		set_ball(direction)
		set_process_input(false)

func create_pos_array():
	var pos = Vector2(39, 74.0)
	for n in 7:
		positions.append(pos + Vector2(brick_offset.x * n, 0))

func place_bricks():
	var num_bricks = randi_range(1, 6)
	
	positions.shuffle()
	
	for i in num_bricks:
		var brick = brick_scene.instantiate()
		
		brick.max_health = level
		
		var doubled = randf()
		if doubled < 0.25:
			brick.max_health *= 2
			
		brick.position = positions[i]
		
		add_child(brick)
	
	if level > 1:
		var powerup = powerup_scene.instantiate()
		powerup.position = positions[num_bricks]
		add_child(powerup)

func move_bricks():
	var tween = create_tween().set_parallel()
	for node in get_tree().get_nodes_in_group("hittables"):
		tween.tween_property(node, "position", node.position + Vector2(0, 67), 0.3)

func set_ball(direction):
	for ball in balls:
		ball.velocity = ball_speed * direction
		in_motion += 1
		num_balls -= 1
		$HUD.update_ball_count(num_balls)
		await get_tree().create_timer(0.1).timeout
		


func set_in_motion() -> void:
	if in_motion > 0:
		in_motion -= 1
	
	if in_motion == 0:
		load_next_level()


func load_next_level():
	$Floor.first_hit = false
	level += 1
	$HUD.update_level(level)
	place_bricks()
	move_bricks()
	add_balls()
	$HUD.place_ball_count(ball_position)
	set_process_input(true)
	
func new_ball():
	new_balls += 1
	
func add_balls():
	for i in new_balls:
		var ball = ball_scene.instantiate()
		balls.append(ball)
		ball.position = ball_position
		add_child(ball)
	num_balls = balls.size()
	$HUD.update_ball_count(num_balls)
	new_balls = 0
	
