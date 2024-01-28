class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL := 0.2
const MAX_HAND_SIZE: int = 8

@export var stats: PlayerResources : set = set_player_stats
@export var hand: Hand
@onready var attack_button = $"../AttackButton"
@onready var discard_button = $"../DiscardButton"
@onready var played_cards = $"../CardUI/PlayedCards"
@onready var enemy = $"../CardUI/Enemy"
@onready var play_area = $"../CardUI/PlayArea"
@onready var enemy_deck = $"../CardUI/Enemy/EnemyDeck"
@onready var face_up_enemy = $"../CardUI/Enemy/FaceUpEnemy"
@onready var jokers = $"../CardUI/Jokers"
@onready var shield_label = $"../CardUI/ShieldIcon/Label"
@onready var on_loss = $"../OnLoss"

var player: PlayerResources
var shields: int = 0
var enemy_attack_damage: int
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
	
func draw_cards(amount: int, doTween: bool = true) -> void:
	if doTween:
		var tween := create_tween()
		for i in range(amount):
			tween.tween_callback(draw_card)
			tween.tween_interval(HAND_DRAW_INTERVAL)
	else:
		for i in range(amount):
			draw_card()

func _on_attack_button_pressed(total, has_hearts, has_diamonds, has_spades, has_clubs, cards_played):
	#print(player.discard)
	var perfect_kill: bool = false
	current_hand_size -= cards_played
	if has_diamonds:
		shields += total
		shield_label.text = str(shields)
	if has_hearts:
		draw_cards(total, false)
	if has_spades:
		return_graveyard(total)
	if has_clubs:
		total *= 2
	var enemy_card
	for card in enemy.get_children():
		if card.is_in_group("enemy_card"):
			enemy_card = card
			break
	if enemy_card.health == total:
		perfect_kill = true
		jokers.flip_a_joker()
	enemy_card.health -= total
	enemy_card.update_stats()
	var hand_value_total: int = 0
	for card in hand.get_children():
		hand_value_total += card.card.value + 1
	for card in play_area.get_children():
		card.reparent(played_cards)
		played_cards.sort_children()
		card.played = true
	#print(hand_value_total)
	if hand_value_total < enemy_card.attack_value:
		on_loss.visible = true
	if enemy_card.health > 0:
		enemy_attacks(enemy_card.attack_value)
	else:
		var new_card = Card.new()
		new_card.suit = enemy_card.card.suit
		new_card.value = enemy_card.card.value
		
		for card in played_cards.get_children():
			player.discard.add_card(card.card)
			card.queue_free()
		shields = 0
		shield_label.text = str(shields)
		if perfect_kill:
			player.draw_pile.add_card(enemy_deck.deck.cards[0], true)
		else:
			player.draw_pile.add_card(enemy_deck.deck.cards[0])
		enemy_deck.deck.cards.remove_at(0)
		if enemy_deck.deck.cards.size() == 0:
			on_loss.text = "You've Won!"
			on_loss.visible = true
		face_up_enemy._set_card(enemy_deck.deck.cards[0])
		face_up_enemy.update_stats()
		face_up_enemy.new_card_stats(enemy_deck.deck.cards[0].value)
		
	

func return_graveyard(amount: int):
	var cards_left = amount
	
	#while cards_left > 1 or player.discard.size() > 0:
		#player.discard
		#cards_left -= 1
	#pass

func enemy_attacks(attack_value: int) -> void:
	enemy_attack_damage = (attack_value - shields)
	attack_button.visible = false
	discard_button.visible = true
	

func _on_discard_button_pressed():
	var value_total: int = 0
	for card in play_area.get_children():
		value_total += card.card.value + 1
	if value_total >= enemy_attack_damage or enemy_attack_damage == 0:
		var play_area_size:int = play_area.get_children().size()
		var discarded_values = {}
		for card in play_area.get_children():
			var value = card.card.value
			if value in discarded_values:
				discarded_values[value] += 1
			else:
				discarded_values[value] = 1
			player.discard.add_card(card.card)
			card.queue_free()
		for value in discarded_values.keys():
			var count = discarded_values[value]
			if count >= 2:
				jokers.flip_a_joker()
		current_hand_size -= play_area_size
		discard_button.visible = false
		attack_button.visible = true
