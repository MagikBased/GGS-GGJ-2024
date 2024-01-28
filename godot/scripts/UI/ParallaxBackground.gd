extends ParallaxBackground

var speed: int = 10
var rotation_speed: float = 0.3

var direction = Vector2(1,1)

func _process(delta):
	scroll_offset += direction * speed * delta
