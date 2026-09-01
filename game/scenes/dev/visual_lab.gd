extends Control

const MAIN_MENU_ROUTE := &"main_menu"
const WORLD_LEFT := 0
const WORLD_TOP := 0
const WORLD_RIGHT := 1920
const WORLD_BOTTOM := 1080

@onready var player_camera: Camera2D = $TestWorld/HeroCharacter/PlayerCamera

var _navigation_requested := false


func _ready() -> void:
	player_camera.limit_left = WORLD_LEFT
	player_camera.limit_top = WORLD_TOP
	player_camera.limit_right = WORLD_RIGHT
	player_camera.limit_bottom = WORLD_BOTTOM
	player_camera.position_smoothing_enabled = false
	player_camera.zoom = Vector2.ONE
	player_camera.enabled = true
	player_camera.make_current()


func _unhandled_input(event: InputEvent) -> void:
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
