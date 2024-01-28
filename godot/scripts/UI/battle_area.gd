class_name BattleUI
extends CanvasLayer

@onready var hand = $Hand
@export var player_stats: PlayerResources : set = set_char_stats

func set_char_stats(value: PlayerResources) -> void:
	player_stats = value
