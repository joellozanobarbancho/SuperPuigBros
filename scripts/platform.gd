@tool
extends StaticBody2D

const GroundTex = preload("res://assets/ground.png")
const PlatTex   = preload("res://assets/platform.png")

@export var platform_size: Vector2 = Vector2(150, 16):
	set(v):
		platform_size = v
		_try_refresh()

@export var ground_style: bool = false:
	set(v):
		ground_style = v
		_try_refresh()

func _ready() -> void:
	_try_refresh()

func _try_refresh() -> void:
	if not has_node("CollisionShape2D") or not has_node("Visual"):
		return
	_refresh()

func _refresh() -> void:
	var shape_node: CollisionShape2D = $CollisionShape2D
	var visual: Polygon2D = $Visual

	var s := RectangleShape2D.new()
	s.size = platform_size
	shape_node.shape = s

	var hw := platform_size.x * 0.5
	var hh := platform_size.y * 0.5
	visual.polygon = PackedVector2Array([
		Vector2(-hw, -hh), Vector2(hw, -hh),
		Vector2(hw,  hh),  Vector2(-hw, hh),
	])
	visual.uv = PackedVector2Array([
		Vector2(0, 0),               Vector2(platform_size.x, 0),
		Vector2(platform_size.x, platform_size.y), Vector2(0, platform_size.y),
	])
	visual.texture = GroundTex if ground_style else PlatTex
	visual.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
