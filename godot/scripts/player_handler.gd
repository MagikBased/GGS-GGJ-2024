class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL := 0.2
const MAX_HAND_SIZE: int = 8

@export var stats: PlayerResources : set = set_player_stats
@export var hand: Hand
@onready var attack_button = $"../AttackButton"
var player: PlayerResources
var shields: int = 0
var current_hand_size:int = 0


func _ready():
	attack_button.connect("values_calculated", Callable(self, "_on_attack_button_pressed"))

func set_player_stats(value: PlayerResources) -> void:
	stats = value.create_instance()

func start_battle(input_stats: PlayerResources) -> void:
	player = input_stats
	player.draw_pile = player.deck.duplicate(true)
	player.draw_pile.shuffle()
	player.discard = CardPile.new()
	start_turn()
	
func start_turn() -> void:
	draw_cards(8)
	
func draw_card() -> void:
	if current_hand_size < MAX_HAND_SIZE:
		hand.add_card(player.draw_pile.draw_card())
		current_hand_size += 1
	
func draw_cards(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	#tween.finished.connect(func(): Events.player_hand_drawn.emit())

func _on_attack_button_pressed(total, has_hearts, has_diamonds, has_spades, has_clubs, cards_played):
	current_hand_size -= cards_played
	if has_diamonds:
		shields += total
	if has_hearts:
		draw_cards(total)
	if has_spades:
		pass
	if has_clubs:
		total *= 2
