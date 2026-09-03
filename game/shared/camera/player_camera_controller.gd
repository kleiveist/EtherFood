extends Camera2D
class_name PlayerCameraController

## Applies a scene profile and the temporary sneak zoom to the player camera.

const CameraProfileResource := preload("res://shared/resources/camera_profile.gd")
const DEFAULT_PROFILE := preload("res://shared/resources/camera_world_v0.tres")

@export var profile: CameraProfileResource = DEFAULT_PROFILE
@export_range(0.1, 4.0, 0.05) var sneak_zoom: float = 1.5

var _sneak_active := false


func _ready() -> void:
	_apply_zoom()


## Replaces the scene profile without changing temporary sneak state.
func set_profile(next_profile: CameraProfileResource) -> Error:
	if next_profile == null:
		return ERR_INVALID_PARAMETER
	profile = next_profile
	_apply_zoom()
	return OK


## Returns the scene-owned zoom before temporary movement overrides.
func get_base_zoom() -> float:
	if profile == null:
		return 1.0
	return maxf(profile.base_zoom, 0.1)


## Returns the uniform zoom currently applied to the camera.
func get_active_zoom() -> float:
	return zoom.x


## Reports whether the temporary sneak profile is active.
func is_sneak_zoom_active() -> bool:
	return _sneak_active


func _on_sneak_state_changed(active: bool) -> void:
	if _sneak_active == active:
		return
	_sneak_active = active
	_apply_zoom()


func _apply_zoom() -> void:
	var target_zoom := maxf(sneak_zoom, 0.1) if _sneak_active else get_base_zoom()
	zoom = Vector2.ONE * target_zoom
