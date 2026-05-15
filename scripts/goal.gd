extends Area2D

signal reached(all_coins: bool)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		reached.emit(GameState.coins_collected >= GameState.total_coins)
