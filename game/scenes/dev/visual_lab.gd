extends Control

enum CameraZoomPreset {
	WIDE,
	MEDIUM,
	NEAR,
}

const MAIN_MENU_ROUTE := &"main_menu"
const ZOOM_OUT_ACTION := &"dev_camera_zoom_out"
const ZOOM_IN_ACTION := &"dev_camera_zoom_in"
const WORLD_LEFT := 0
const WORLD_TOP := 0
const WORLD_RIGHT := 1920
const WORLD_BOTTOM := 1080
const CAMERA_ZOOM_NAMES: Array[String] = ["Weit", "Mittel", "Nah"]
const CAMERA_ZOOM_VALUES: Array[float] = [0.75, 1.0, 1.5]

@onready var player_camera: Camera2D = $TestWorld/HeroCharacter/PlayerCamera
@onready var camera_status: Label = $InterfaceLayer/Interface/Text/CameraStatus

var _navigation_requested := false
var _selected_camera_zoom: int = CameraZoomPreset.MEDIUM


func _ready() -> void:
	player_camera.limit_left = WORLD_LEFT
	player_camera.limit_top = WORLD_TOP
	player_camera.limit_right = WORLD_RIGHT
	player_camera.limit_bottom = WORLD_BOTTOM
	player_camera.position_smoothing_enabled = false
	player_camera.enabled = true
	player_camera.make_current()
	resized.connect(_on_visual_lab_resized)
	_apply_camera_zoom()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(ZOOM_OUT_ACTION):
		get_viewport().set_input_as_handled()
		_change_camera_zoom(-1)
		return
	if event.is_action_pressed(ZOOM_IN_ACTION):
		get_viewport().set_input_as_handled()
		_change_camera_zoom(1)
		return
	if _navigation_requested or not event.is_action_pressed(&"ui_cancel"):
		return

	get_viewport().set_input_as_handled()
	_navigation_requested = true
	var navigation_error := SceneRouter.navigate(MAIN_MENU_ROUTE)
	if navigation_error == OK:
		return

	_navigation_requested = false
	push_error(
		"VisualLab failed to navigate to route '%s' with error %d."
		% [MAIN_MENU_ROUTE, navigation_error],
	)


func _change_camera_zoom(direction: int) -> void:
	var next_zoom := clampi(
		_selected_camera_zoom + direction,
		CameraZoomPreset.WIDE,
		CameraZoomPreset.NEAR,
	)
	if next_zoom == _selected_camera_zoom:
		return
	_selected_camera_zoom = next_zoom
	_apply_camera_zoom()


func _apply_camera_zoom() -> void:
	var selected_zoom := CAMERA_ZOOM_VALUES[_selected_camera_zoom]
	var effective_zoom := maxf(selected_zoom, _minimum_camera_zoom())
	player_camera.zoom = Vector2(effective_zoom, effective_zoom)
	var limited_suffix := ""
	if effective_zoom > selected_zoom:
		limited_suffix = " · durch Weltgröße begrenzt"
	camera_status.text = "Kamera: %s · %s×%s" % [
		CAMERA_ZOOM_NAMES[_selected_camera_zoom],
		_format_camera_zoom(effective_zoom),
		limited_suffix,
	]


func _minimum_camera_zoom() -> float:
	var viewport_size := size
	if viewport_size.x <= 0.0 or viewport_size.y <= 0.0:
		viewport_size = Vector2(
			float(ProjectSettings.get_setting("display/window/size/viewport_width", 0)),
			float(ProjectSettings.get_setting("display/window/size/viewport_height", 0)),
		)
	var world_width := float(WORLD_RIGHT - WORLD_LEFT)
	var world_height := float(WORLD_BOTTOM - WORLD_TOP)
	return maxf(viewport_size.x / world_width, viewport_size.y / world_height)


func _format_camera_zoom(zoom_value: float) -> String:
	return ("%.2f" % zoom_value).replace(".", ",")


func _on_visual_lab_resized() -> void:
	_apply_camera_zoom()
