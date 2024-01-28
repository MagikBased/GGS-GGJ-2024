extends CardState

func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	if card_ui.playarea.size() > 0:
		var play_area = get_tree().get_first_node_in_group("play_area")
		card_ui.reparent_requested.emit(card_ui, play_area)
		card_ui.pivot_offset = Vector2.ZERO
	else:
		var hand = get_tree().get_first_node_in_group("hand")
		card_ui.reparent_requested.emit(card_ui, hand)
		card_ui.pivot_offset = Vector2.ZERO
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self,CardState.State.CLICKED)
