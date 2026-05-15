extends Node2D

@onready var hud    = $HUD
@onready var player = $Player

func _ready() -> void:
	GameState.coins_collected = 0

	GameState.total_coins = $Coins.get_child_count()
	hud.update_lives(GameState.lives)
	hud.update_coins(0, GameState.total_coins)

	for coin in $Coins.get_children():
		coin.coin_collected.connect(_on_coin_collected)

	for enemy in $Enemies.get_children():
		enemy.hit_player.connect(_on_enemy_hit_player)

	$Goal.reached.connect(_on_goal_reached)
	player.fell_into_pit.connect(_on_player_fell)

# ──────────────────────────────────────────────
#  Shared life-loss logic
# ──────────────────────────────────────────────
func _lose_life() -> void:
	GameState.lives -= 1
	hud.update_lives(GameState.lives)
	if GameState.lives <= 0:
		hud.show_message("GAME OVER!")
		player.disable_movement()
		await get_tree().create_timer(2.5).timeout
		GameState.reset_all()
		get_tree().reload_current_scene()
	else:
		get_tree().reload_current_scene()

func _on_player_fell() -> void:
	_lose_life()

func _on_enemy_hit_player() -> void:
	_lose_life()

func _on_coin_collected() -> void:
	GameState.coins_collected += 1
	hud.update_coins(GameState.coins_collected, GameState.total_coins)

func _on_goal_reached(all_coins: bool) -> void:
	player.disable_movement()
	if all_coins:
		hud.show_message("LEVEL COMPLETE!\nAll coins collected!")
	else:
		var missing := GameState.total_coins - GameState.coins_collected
		hud.show_message("Level complete!\nYou missed " + str(missing) + " coin(s)!")
	await get_tree().create_timer(5.0).timeout
	get_tree().quit()
