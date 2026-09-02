extends CharacterBody2D

signal interaction_target_changed(target: Area2D)

const APPEARANCE_REFERENCE_HEIGHT := 80.0

@export_range(50.0, 1000.0, 10.0)
var move_speed: float = 220.0

var facing_direction: Vector2 = Vector2.DOWN
var _movement_enabled := true
var _interaction_target: Area2D = null

@onready var appearance: Node2D = $Visual/Appearance
@onready var facing_marker: Polygon2D = $Visual/FacingMarker
@onready var interaction_detector: Area2D = $InteractionDetector


func _ready() -> void:
	_update_facing_marker()
	_refresh_interaction_target()


func _physics_process(_delta: float) -> void:
	_refresh_interaction_target()
	if not _movement_enabled:
		velocity = Vector2.ZERO
		return

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


func set_movement_enabled(enabled: bool) -> void:
	_movement_enabled = enabled
	if not _movement_enabled:
		velocity = Vector2.ZERO


func is_movement_enabled() -> bool:
	return _movement_enabled


func get_nearest_interactable() -> Area2D:
	_refresh_interaction_target()
	return _interaction_target


func try_interact() -> bool:
	_refresh_interaction_target()
	if _interaction_target == null:
		return false
	return bool(_interaction_target.call(&"interact", self))


func set_appearance_height(target_height: float) -> void:
	var uniform_scale := target_height / APPEARANCE_REFERENCE_HEIGHT
	appearance.scale = Vector2(uniform_scale, uniform_scale)


func get_appearance_height() -> float:
	return APPEARANCE_REFERENCE_HEIGHT * appearance.scale.y


func _update_facing_direction(direction: Vector2) -> void:
	if absf(direction.x) > absf(direction.y):
		facing_direction = Vector2.RIGHT if direction.x > 0.0 else Vector2.LEFT
	else:
		facing_direction = Vector2.DOWN if direction.y > 0.0 else Vector2.UP
	_update_facing_marker()


func _update_facing_marker() -> void:
	facing_marker.rotation = facing_direction.angle() - Vector2.DOWN.angle()


func _refresh_interaction_target() -> void:
	var nearest_target: Area2D = null
	var nearest_distance_squared := INF
	for candidate in interaction_detector.get_overlapping_areas():
		if not _is_valid_interaction_target(candidate):
			continue
		var distance_squared := global_position.distance_squared_to(
			candidate.global_position
		)
		if distance_squared < nearest_distance_squared:
			nearest_target = candidate
			nearest_distance_squared = distance_squared

	if nearest_target == _interaction_target:
		return
	_interaction_target = nearest_target
	interaction_target_changed.emit(_interaction_target)


func _is_valid_interaction_target(candidate: Area2D) -> bool:
	return (
		candidate.has_method(&"interact")
		and candidate.has_method(&"is_interactable")
		and candidate.has_method(&"get_interaction_prompt")
		and bool(candidate.call(&"is_interactable", self))
	)
