class_name Hand
extends HBoxContainer

@export var card_ui := preload("res://scenes/card_ui/card_ui.tscn")

func _ready() -> void:
	pass
	
func add_card(card: Card) -> void:
	var new_card_ui := card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	#new_card_ui.parent = self

func _on_card_ui_reparent_requested(child: CardUI, zone) -> void:
	child.reparent(zone)
