extends Node2D

@export var player_stats: PlayerResources
@onready var card_ui = $CardUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler

func _ready() -> void:
	start_battle()


func start_battle() -> void:
	player_handler.start_battle(player_handler.stats)
