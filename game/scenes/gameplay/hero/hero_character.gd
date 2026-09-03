extends CharacterBody2D

signal interaction_target_changed(target: Area2D)
signal sneak_state_changed(active: bool)

enum MovementState {
	WALK,
	RUN,
	BOOST,
	SNEAK,
}

enum JumpState {
	GROUND,
	NORMAL,
	RUN,
	BOOST,
}

const APPEARANCE_REFERENCE_HEIGHT := 80.0
const AIR_CONTROL_TURN_RATE := 2.5
const MOVE_LEFT_ACTION := &"gameplay_move_left"
const MOVE_RIGHT_ACTION := &"gameplay_move_right"
const MOVE_UP_ACTION := &"gameplay_move_up"
const MOVE_DOWN_ACTION := &"gameplay_move_down"
const JUMP_ACTION := &"gameplay_jump"
const SNEAK_ACTION := &"gameplay_sneak"
const BOOST_ACTION := &"gameplay_boost"
const MOVEMENT_ACTIONS: Array[StringName] = [
	MOVE_UP_ACTION,
	MOVE_DOWN_ACTION,
	MOVE_LEFT_ACTION,
	MOVE_RIGHT_ACTION,
]
const HeroMovementConfigResource := preload(
	"res://shared/resources/hero_movement_config.gd"
)
const DEFAULT_MOVEMENT_CONFIG := preload(
	"res://shared/resources/hero_movement_v0.tres"
)

@export var movement_config: HeroMovementConfigResource = DEFAULT_MOVEMENT_CONFIG

var facing_direction: Vector2 = Vector2.DOWN
var _movement_enabled := true
var _interaction_target: Area2D = null
var _movement_state: MovementState = MovementState.WALK
var _jump_state: JumpState = JumpState.GROUND
var _run_active := false
var _sneak_active := false
var _boost_time_remaining := 0.0
var _direction_change_time_remaining := 0.0
var _tap_time_remaining: Dictionary[StringName, float] = {}
var _tap_released: Dictionary[StringName, bool] = {}
var _jump_elapsed := 0.0
var _jump_duration := 0.0
var _jump_distance := 0.0
var _jump_height := 0.0
var _jump_direction := Vector2.DOWN
var _jump_visual_base_position := Vector2.ZERO

@onready var jump_visual: Node2D = $Visual/JumpVisual
@onready var appearance: Node2D = $Visual/JumpVisual/Appearance
@onready var facing_marker: Polygon2D = $Visual/JumpVisual/FacingMarker
@onready var interaction_detector: Area2D = $InteractionDetector


func _ready() -> void:
	_jump_visual_base_position = jump_visual.position
	_initialize_double_tap_tracking()
	_update_facing_marker()
	_refresh_interaction_target()


func _input(event: InputEvent) -> void:
	if not _movement_enabled or event.device != InputEvent.DEVICE_ID_KEYBOARD:
		return
	for action in MOVEMENT_ACTIONS:
		if event.is_action_pressed(action):
			_handle_direction_press(action)
			return
		if event.is_action_released(action):
			_handle_direction_release(action)
			return
	if event.is_action_pressed(SNEAK_ACTION):
		_set_sneak_active(true)
		_update_movement_state()
		return
	if event.is_action_released(SNEAK_ACTION):
		_set_sneak_active(false)
		_update_movement_state()
		return
	if event.is_action_pressed(JUMP_ACTION):
		_start_jump()


func _physics_process(delta: float) -> void:
	_refresh_interaction_target()
	if not _movement_enabled:
		velocity = Vector2.ZERO
		_set_sneak_active(false)
		_movement_state = MovementState.WALK
		return

	_advance_timers(delta)
	var direction := _movement_direction()
	_update_run_release_grace(direction, delta)
	_set_sneak_active(Input.is_action_pressed(SNEAK_ACTION))
	_update_movement_state()
	if not direction.is_zero_approx():
		_update_facing_direction(direction)
	if is_jumping():
		_advance_jump(delta, direction)
		return
	velocity = direction * get_current_speed()
	move_and_slide()


func set_movement_enabled(enabled: bool) -> void:
	if _movement_enabled == enabled:
		return
	_movement_enabled = enabled
	if not _movement_enabled:
		velocity = Vector2.ZERO
		_reset_transient_movement()


func is_movement_enabled() -> bool:
	return _movement_enabled


## Returns the resolved movement state after applying priority rules.
func get_movement_state() -> MovementState:
	return _movement_state


## Returns the jump tier fixed at takeoff, or GROUND after landing.
func get_jump_state() -> JumpState:
	return _jump_state


## Reports whether the visual jump curve and jump movement are active.
func is_jumping() -> bool:
	return _jump_state != JumpState.GROUND


## Returns the current boost lifetime in seconds without exposing its timer.
func get_boost_time_remaining() -> float:
	return _boost_time_remaining


## Returns the speed selected by movement priority, or zero while disabled.
func get_current_speed() -> float:
	if not _movement_enabled:
		return 0.0
	match _movement_state:
		MovementState.SNEAK:
			return movement_config.sneak_speed
		MovementState.BOOST:
			return movement_config.boost_speed
		MovementState.RUN:
			return movement_config.run_speed
		_:
			return movement_config.walk_speed


## Returns the German movement label used by the visual diagnostics.
func get_movement_diagnostic() -> String:
	match _movement_state:
		MovementState.SNEAK:
			return "Schleichen"
		MovementState.BOOST:
			return "Boostlauf · %s s" % _format_seconds(_boost_time_remaining)
		MovementState.RUN:
			return "Schnelllauf"
		_:
			return "Normal"


## Returns the German jump label used by the visual diagnostics.
func get_jump_diagnostic() -> String:
	match _jump_state:
		JumpState.NORMAL:
			return "Standard"
		JumpState.RUN:
			return "Lauf"
		JumpState.BOOST:
			return "Boost"
		_:
			return "Boden"


func get_nearest_interactable() -> Area2D:
	_refresh_interaction_target()
	return _interaction_target


func try_interact() -> bool:
	if not _movement_enabled or is_jumping():
		return false
	_refresh_interaction_target()
	if _interaction_target == null:
		return false
	return bool(_interaction_target.call(&"interact", self))


func set_appearance_height(target_height: float) -> void:
	var uniform_scale := target_height / APPEARANCE_REFERENCE_HEIGHT
	appearance.scale = Vector2(uniform_scale, uniform_scale)


func get_appearance_height() -> float:
	return APPEARANCE_REFERENCE_HEIGHT * appearance.scale.y


func _movement_direction() -> Vector2:
	return Input.get_vector(
		MOVE_LEFT_ACTION,
		MOVE_RIGHT_ACTION,
		MOVE_UP_ACTION,
		MOVE_DOWN_ACTION,
	)


func _initialize_double_tap_tracking() -> void:
	for action in MOVEMENT_ACTIONS:
		_tap_time_remaining[action] = 0.0
		_tap_released[action] = false


func _handle_direction_press(action: StringName) -> void:
	if (
		_tap_time_remaining[action] > 0.0
		and _tap_released[action]
	):
		_run_active = true
		_direction_change_time_remaining = movement_config.direction_change_grace
		if (
			Input.is_action_pressed(BOOST_ACTION)
			and _boost_time_remaining <= 0.0
		):
			_boost_time_remaining = movement_config.boost_duration
		_tap_time_remaining[action] = 0.0
		_tap_released[action] = false
		_update_movement_state()
		return

	_tap_time_remaining[action] = movement_config.double_tap_window
	_tap_released[action] = false


func _handle_direction_release(action: StringName) -> void:
	if _tap_time_remaining[action] > 0.0:
		_tap_released[action] = true


func _advance_timers(delta: float) -> void:
	for action in MOVEMENT_ACTIONS:
		if _tap_time_remaining[action] <= 0.0:
			continue
		_tap_time_remaining[action] = maxf(
			0.0,
			_tap_time_remaining[action] - delta,
		)
		if _tap_time_remaining[action] <= 0.0:
			_tap_released[action] = false
	if _boost_time_remaining > 0.0:
		_boost_time_remaining = maxf(0.0, _boost_time_remaining - delta)


func _update_run_release_grace(direction: Vector2, delta: float) -> void:
	if not _run_active:
		return
	if not direction.is_zero_approx():
		_direction_change_time_remaining = movement_config.direction_change_grace
		return
	_direction_change_time_remaining = maxf(
		0.0,
		_direction_change_time_remaining - delta,
	)
	if _direction_change_time_remaining <= 0.0:
		_run_active = false


func _set_sneak_active(active: bool) -> void:
	if _sneak_active == active:
		return
	_sneak_active = active
	sneak_state_changed.emit(_sneak_active)


func _update_movement_state() -> void:
	if _sneak_active:
		_movement_state = MovementState.SNEAK
	elif _boost_time_remaining > 0.0:
		_movement_state = MovementState.BOOST
	elif _run_active:
		_movement_state = MovementState.RUN
	else:
		_movement_state = MovementState.WALK


func _start_jump() -> void:
	if is_jumping():
		return
	_jump_state = _jump_state_for_movement()
	_jump_elapsed = 0.0
	_jump_direction = _movement_direction()
	if _jump_direction.is_zero_approx():
		_jump_direction = facing_direction
	else:
		_jump_direction = _jump_direction.normalized()
	_apply_jump_profile()


func _jump_state_for_movement() -> JumpState:
	if Input.is_action_pressed(SNEAK_ACTION):
		return JumpState.NORMAL
	match _movement_state:
		MovementState.BOOST:
			return JumpState.BOOST
		MovementState.RUN:
			return JumpState.RUN
		_:
			return JumpState.NORMAL


func _apply_jump_profile() -> void:
	match _jump_state:
		JumpState.RUN:
			_jump_duration = movement_config.run_jump_duration
			_jump_distance = movement_config.run_jump_distance
			_jump_height = movement_config.run_jump_height
		JumpState.BOOST:
			_jump_duration = movement_config.boost_jump_duration
			_jump_distance = movement_config.boost_jump_distance
			_jump_height = movement_config.boost_jump_height
		_:
			_jump_duration = movement_config.normal_jump_duration
			_jump_distance = movement_config.normal_jump_distance
			_jump_height = movement_config.normal_jump_height
	_jump_duration = maxf(_jump_duration, 0.01)


func _advance_jump(delta: float, input_direction: Vector2) -> void:
	if not input_direction.is_zero_approx():
		var turn_weight := clampf(delta * AIR_CONTROL_TURN_RATE, 0.0, 1.0)
		_jump_direction = _jump_direction.lerp(
			input_direction.normalized(),
			turn_weight,
		).normalized()
	var remaining_duration := maxf(0.0, _jump_duration - _jump_elapsed)
	var movement_delta := minf(delta, remaining_duration)
	var final_frame_ratio := movement_delta / delta if delta > 0.0 else 0.0
	velocity = (
		_jump_direction
		* (_jump_distance / _jump_duration)
		* final_frame_ratio
	)
	move_and_slide()
	_jump_elapsed += movement_delta
	var progress := clampf(_jump_elapsed / _jump_duration, 0.0, 1.0)
	var visible_height := 4.0 * _jump_height * progress * (1.0 - progress)
	jump_visual.position = _jump_visual_base_position + Vector2.UP * visible_height
	if _jump_elapsed >= _jump_duration:
		_finish_jump()


func _finish_jump() -> void:
	_jump_state = JumpState.GROUND
	_jump_elapsed = 0.0
	velocity = Vector2.ZERO
	if is_instance_valid(jump_visual):
		jump_visual.position = _jump_visual_base_position


func _reset_transient_movement() -> void:
	_run_active = false
	_boost_time_remaining = 0.0
	_direction_change_time_remaining = 0.0
	_set_sneak_active(false)
	_movement_state = MovementState.WALK
	for action in MOVEMENT_ACTIONS:
		_tap_time_remaining[action] = 0.0
		_tap_released[action] = false
	if is_jumping():
		_finish_jump()


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


func _format_seconds(seconds: float) -> String:
	return ("%.1f" % maxf(seconds, 0.0)).replace(".", ",")
