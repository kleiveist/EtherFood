extends CharacterBody2D

@export_range(50.0, 1000.0, 10.0)
var move_speed: float = 220.0

var facing_direction: Vector2 = Vector2.DOWN

@onready var facing_marker: Polygon2D = $Visual/FacingMarker


func _ready() -> void:
	_update_facing_marker()


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector(
		&"gameplay_move_left",
		&"gameplay_move_right",
		&"gameplay_move_up",
		&"gameplay_move_down",
	)
	velocity = direction * move_speed
	if not direction.is_zero_approx():
		_update_facing_direction(direction)
	move_and_slide()


func _update_facing_direction(direction: Vector2) -> void:
	if absf(direction.x) > absf(direction.y):
		facing_direction = Vector2.RIGHT if direction.x > 0.0 else Vector2.LEFT
	else:
		facing_direction = Vector2.DOWN if direction.y > 0.0 else Vector2.UP
	_update_facing_marker()


func _update_facing_marker() -> void:
	facing_marker.rotation = facing_direction.angle() - Vector2.DOWN.angle()
