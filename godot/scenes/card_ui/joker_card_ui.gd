extends Control

enum Suit_Color{RED,BLACK}

@export var face_up: bool = false
@export var suit: Suit_Color
@onready var card_back = $CardBack
@onready var buttons_h_box_container = $ButtonsHBoxContainer
@onready var face_value = $FaceValue
@onready var face_value_2 = $FaceValue2
@onready var player_handler = $"../../../PlayerHandler"


func _ready():
	if !face_up:
		card_back.visible = true
		buttons_h_box_container.visible = false
	else:
		card_back.visible = false
		buttons_h_box_container.visible = true
	if suit == Suit_Color.RED:
		face_value.add_theme_color_override("font_color", Color.RED)
		face_value_2.add_theme_color_override("font_color", Color.RED)
	elif suit == Suit_Color.BLACK:
		face_value.add_theme_color_override("font_color", Color.BLACK)
		face_value_2.add_theme_color_override("font_color", Color.BLACK)

func put_face_down():
	card_back.visible = true
	buttons_h_box_container.visible = false

func put_face_up():
	card_back.visible = false
	buttons_h_box_container.visible = true

func _on_button_heart_pressed():
	player_handler.draw_cards(4)
	put_face_down()


func _on_button_diamond_pressed():
	put_face_down()
