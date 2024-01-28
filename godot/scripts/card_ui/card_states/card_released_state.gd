extends CardState

var played: bool

func enter() -> void:
	played = false
	
	if not card_ui.playarea.is_empty():
		played = true

func on_input(_event: InputEvent) -> void:
	transition_requested.emit(self,CardState.State.BASE)
