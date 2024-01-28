extends TextureRect

var selected: bool = false
@onready var selected_highlight = $"../selected"
@onready var mini_card = $".."

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		#print(get_global_rect())
		#print((event.position))
		if get_global_rect().has_point((event.position)):
			selected = !selected
			mini_card.selected = selected
			
func _process(_delta):
	if selected:
		selected_highlight.visible = true
	else:
		selected_highlight.visible = false
