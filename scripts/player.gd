extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -480.0

signal fell_into_pit

var _can_move: bool = true
var _fell: bool = false

@onready var _sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if _can_move:
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
			_sprite.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if global_position.y > 950 and not _fell:
		_fell = true
		fell_into_pit.emit()

func disable_movement() -> void:
	_can_move = false
