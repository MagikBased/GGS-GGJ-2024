extends Control

enum Suit { HEARTS, DIAMONDS, SPADES, CLUBS}
enum Value {ACE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE,TEN,JACK,QUEEN,KING}

@onready var hand = $"../Hand"
@onready var h_box_container = $HBoxContainer
@onready var discard_button = $DiscardButton

var mini_card_scene = preload("res://scenes/card_ui/mini_card.tscn")
var cards_in_hand: Array
var discard_total: int
var mini_cards: Array

func _ready():
	await get_tree().create_timer(2.0).timeout
	for card in hand.get_children():
		var card_suit = card.card.suit
		var card_value = card.card.value
		cards_in_hand.append([card_suit,card_value])
	populate_grid()

func populate_grid() -> void:
	mini_cards.clear()
	for card in cards_in_hand:
		var card_texture = get_texture_for_card(card[0],card[1])
		var mini_card_instance = mini_card_scene.instantiate()
		h_box_container.add_child(mini_card_instance)
		mini_card_instance.card.set_texture(card_texture)
		mini_cards.append(mini_card_instance)
		#card_button.connect("pressed", self, "_on_CardButton_pressed", [card_button])
		#card_button.connect("pressed", Callable(self,"_on_button_pressed", [card_button]))



func get_texture_for_card(suit, value) -> Texture:
	var suit_map = {
		Card.Suit.CLUBS: "c",
		Card.Suit.DIAMONDS: "d",
		Card.Suit.SPADES: "s",
		Card.Suit.HEARTS: "h"
	}
	var value_map = {
		Card.Value.ACE: "a",
		Card.Value.TWO: "2",
		Card.Value.THREE: "3",
		Card.Value.FOUR: "4",
		Card.Value.FIVE: "5",
		Card.Value.SIX: "6",
		Card.Value.SEVEN: "7",
		Card.Value.EIGHT: "8",
		Card.Value.NINE: "9",
		Card.Value.TEN: "10",
		Card.Value.JACK: "j",
		Card.Value.QUEEN: "q",
		Card.Value.KING: "k"
	}
	var card_code = suit_map[suit] + value_map[value]
	var texture_path = "res://sprites/tinycards/" + card_code + ".png"
	return load(texture_path)


func _on_discard_button_pressed():
	var card_ids: Array
	for i in mini_cards:
		if i.selected:
			card_ids.append(i)
			pass
	for j in range(mini_cards.size()):
		pass
	print(cards_in_hand)
	print(card_ids)
	visible = false
