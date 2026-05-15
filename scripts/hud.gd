extends CanvasLayer

@onready var lives_label: Label = $LivesLabel
@onready var coins_label: Label = $CoinsLabel
@onready var message_label: Label = $MessageLabel

func update_lives(lives: int) -> void:
	lives_label.text = "Lives: " + str(lives)

func update_coins(collected: int, total: int) -> void:
	coins_label.text = "Coins: " + str(collected) + "/" + str(total)

func show_message(text: String) -> void:
	message_label.text = text
	message_label.visible = true

func hide_message() -> void:
	message_label.visible = false
