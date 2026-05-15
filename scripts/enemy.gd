extends CharacterBody2D

@export var patrol_distance: float = 250.0
@export var speed: float = 80.0

var _direction: int = 1
var _start_x: float = 0.0

signal hit_player

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _floor_ray: RayCast2D = $FloorRay

func _ready() -> void:
	_start_x = global_position.x

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	_floor_ray.position.x = 18.0 * _direction

	if is_on_floor() and not _floor_ray.is_colliding():
		_direction *= -1
	else:
		var dist := global_position.x - _start_x
		if dist >= patrol_distance:
			_direction = -1
		elif dist <= -patrol_distance:
			_direction = 1

	velocity.x = _direction * speed
	_sprite.flip_h = _direction < 0
	move_and_slide()

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		hit_player.emit()
