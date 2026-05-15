extends CanvasLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if visible:
			_hide_menu()
		else:
			_show_menu()

func _show_menu() -> void:
	visible = true
	get_tree().paused = true

func _hide_menu() -> void:
	visible = false
	get_tree().paused = false

func _on_resume_button_pressed() -> void:
	_hide_menu()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
