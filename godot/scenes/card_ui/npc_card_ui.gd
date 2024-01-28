extends Control


@export var card: Card : set = _set_card
@export var face_up: bool = false
@export var in_play: bool = false
@onready var face_value = $FaceValue
@onready var face_value_2 = $FaceValue2
@onready var suit = $Suit
@onready var suit_2 = $Suit2
@onready var card_back = $CardBack

func _ready() -> void:
	if !face_up:
		card_back.visible = true
	

func _set_card(input_card: Card) -> void:
	#♠♥♦♣
	if not is_node_ready():
		await ready
	card = input_card
	var value_text = return_face_value(card)
	var suit_text = return_suit_value(card)
	face_value.text = value_text
	face_value_2.text = value_text
	suit.text = suit_text
	suit_2.text = suit_text
	if card.suit == card.Suit.DIAMONDS or card.suit == card.Suit.HEARTS:
		suit.add_theme_color_override("font_color", Color.RED)
		suit_2.add_theme_color_override("font_color", Color.RED)
		face_value.add_theme_color_override("font_color", Color.RED)
		face_value_2.add_theme_color_override("font_color", Color.RED)
	else:
		suit.add_theme_color_override("font_color",Color.BLACK)
		suit_2.add_theme_color_override("font_color", Color.BLACK)
		face_value.add_theme_color_override("font_color", Color.BLACK)
		face_value_2.add_theme_color_override("font_color", Color.BLACK)

func return_face_value(input_card: Card) -> String:
	var card_value = input_card.value
	match card_value:
		input_card.Value.ACE:
			card_value = str("A")
		input_card.Value.TWO:
			card_value = str(2)
		input_card.Value.THREE:
			card_value = str(3)
		input_card.Value.FOUR:
			card_value = str(4)
		input_card.Value.FIVE:
			card_value = str(5)
		input_card.Value.SIX:
			card_value = str(6)
		input_card.Value.SEVEN:
			card_value = str(7)
		input_card.Value.EIGHT:
			card_value = str(8)
		input_card.Value.NINE:
			card_value = str(9)
		input_card.Value.TEN:
			card_value = str(10)
		input_card.Value.JACK:
			card_value = str("J")
		input_card.Value.QUEEN:
			card_value = str("Q")
		input_card.Value.KING:
			card_value = str("K")
	return card_value

func return_suit_value(input_card: Card) -> String:
	#♠♥♦♣
	var card_suit = input_card.suit
	match card_suit:
		input_card.Suit.HEARTS:
			card_suit = "♥"
		input_card.Suit.DIAMONDS:
			card_suit = "♦"
		input_card.Suit.SPADES:
			card_suit = "♠"
		input_card.Suit.CLUBS:
			card_suit = "♣"
	return card_suit

func set_art():
	pass
