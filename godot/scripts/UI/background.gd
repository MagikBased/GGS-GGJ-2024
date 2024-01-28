extends TextureRect

var speed = Vector2(-50, -50) 

func _process(delta):
	var current_offset = self.rect_offset
	current_offset += speed * delta
	self.rect_offset = current_offset
