extends TextureButton

@onready var play_area = $"../CardUI/PlayArea"
@onready var player_handler = $"../PlayerHandler"
var cards: Array
var total: int = 0
var can_attack: bool = false
var has_hearts: bool = false
var has_diamonds: bool = false
var has_spades: bool = false
var has_clubs: bool = false

signal values_calculated(can_attack, total, has_hearts, has_diamonds, has_spades, has_clubs)

func _ready():
	pass

func _on_pressed():
	cards = []
	total = 0
	can_attack = false
	has_hearts = false
	has_diamonds = false
	has_spades = false
	has_clubs = false
	for card in play_area.get_children():
		var face_value = return_face_value(card.card)
		var suit_value = return_suit_value(card.card)
		cards.append([face_value,suit_value])
		if suit_value == "♥":
			has_hearts = true
		elif suit_value == "♦":
			has_diamonds = true
		elif suit_value == "♠":
			has_spades = true
		elif suit_value == "♣":
			has_clubs = true
	for i in range(cards.size()):
		total += cards[i][0]
	if cards.size() > 1:
		var wildcard_count = 0
		var base_value = -1

		for card in cards:
			if card[0] == 1:
				wildcard_count += 1
			elif base_value == -1:
				base_value = card[0]
		if wildcard_count == cards.size():
			can_attack = true
		elif base_value != -1:
			var condition_met = true
			for card in cards:
				if card[0] != 1 and card[0] != base_value:
					condition_met = false
					break
			if condition_met:
				can_attack = true
				if wildcard_count == 0:
					if total <= 10:
						can_attack = true
					else:
						can_attack = false
	else:
		can_attack = true

	if can_attack:
		emit_signal("values_calculated", total, has_hearts, has_diamonds, has_spades, has_clubs, cards.size())
	

func return_face_value(input_card: Card) -> int:
	var card_value = input_card.value
	var return_value: int
	match card_value:
		input_card.Value.ACE:
			return_value = 1
		input_card.Value.TWO:
			return_value = 2
		input_card.Value.THREE:
			return_value = 3
		input_card.Value.FOUR:
			return_value = 4
		input_card.Value.FIVE:
			return_value = 5
		input_card.Value.SIX:
			return_value = 6
		input_card.Value.SEVEN:
			return_value = 7
		input_card.Value.EIGHT:
			return_value = 8
		input_card.Value.NINE:
			return_value = 9
		input_card.Value.TEN:
			return_value = 10
		input_card.Value.JACK:
			return_value = 10
		input_card.Value.QUEEN:
			return_value = 15
		input_card.Value.KING:
			return_value = 20
	return return_value

func return_suit_value(input_card: Card) -> String:
	#♥♦♠♣
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
