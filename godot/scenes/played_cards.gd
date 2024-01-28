extends Container

func _ready():
	sort_children()


func sort_children():
	var next_position = Vector2(0, 0)
	var max_cards_per_row = 4
	var row_height = 50 
	for i in range(get_child_count()):
		var child = get_child(i)
		if child is Control:
			child.position = next_position
			next_position.x += 30

			if (i + 1) % max_cards_per_row == 0:
				next_position.x = 0
				next_position.y += row_height
