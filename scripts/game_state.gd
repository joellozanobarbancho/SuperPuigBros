extends Node

var lives: int = 3
var coins_collected: int = 0
var total_coins: int = 0

func reset_all() -> void:
	lives = 3
	coins_collected = 0
	total_coins = 0

func reset_level() -> void:
	coins_collected = 0
