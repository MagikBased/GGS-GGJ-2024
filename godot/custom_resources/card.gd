class_name Card
extends Resource

enum Suit { HEARTS, DIAMONDS, SPADES, CLUBS}
enum Value {ACE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE,TEN,JACK,QUEEN,KING}

@export_group("Card Attributes")
#@export var id: String
@export var suit: Suit
@export var value: Value
@export var card_texture: Texture

#@export_group("Card Visuals")
#@export var suit_icon: Texture
