extends HBoxContainer

var jokers: Array

func _ready():
	jokers.append(get_children())
	print(jokers[0][0].face_up)
	

func flip_a_joker() -> void:
	for joker in jokers[0]:
		if joker.face_up == false:
			joker.put_face_up()
			break
