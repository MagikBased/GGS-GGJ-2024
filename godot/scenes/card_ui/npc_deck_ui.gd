extends Control

@export var deck: CardPile

func _ready():
	var jacks = [deck.cards[0],deck.cards[1],deck.cards[2],deck.cards[3]]
	var queens  = [deck.cards[4],deck.cards[5],deck.cards[6],deck.cards[7]]
	var kings = [deck.cards[8],deck.cards[9],deck.cards[10],deck.cards[11]]
	jacks.shuffle()
	queens.shuffle()
	kings.shuffle()
	deck.cards.clear()
	for card in jacks:
		deck.cards.append(card)
	for card in queens:
		deck.cards.append(card)
	for card in kings:
		deck.cards.append(card)
