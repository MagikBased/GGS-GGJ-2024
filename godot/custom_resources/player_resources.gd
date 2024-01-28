class_name PlayerResources
extends Resource

@export var starting_deck: CardPile

var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

func create_instance() -> Resource:
	var instance = PlayerResources
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
