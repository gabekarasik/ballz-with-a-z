extends RigidBody2D

var health
var max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	$Health.text = str(health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit():
	health -= 1
	if health == 0:
		broken()
	else:
		$Health.text = str(health)
	
func broken():
	queue_free()
