extends ParallaxBackground

var speed: int = 10
var rotation_speed: float = 0.3

var direction = Vector2(1,1)
var change_direction_time = 5.0 
var time_passed = 0.0

func _ready():
	randomize()

func _process(delta):
	time_passed += delta
	if time_passed >= change_direction_time:
		time_passed = 0.0
		direction = get_random_direction()
	
	scroll_offset += direction * speed * delta

func get_random_direction() -> Vector2:
	var new_direction = Vector2.ZERO
	while new_direction == Vector2.ZERO:
		new_direction.x = randi() % 3 - 1 
		new_direction.y = randi() % 3 - 1 
	return new_direction
