extends Control

const MAIN_MENU_ROUTE := &"main_menu"
const ROOM_LEFT := 0
const ROOM_TOP := 0
const ROOM_RIGHT := 2560
const ROOM_BOTTOM := 1440
const HERO_HEIGHT := 80.0
const CAMERA_ZOOM := 1.5
const TILE_SIZE := Vector2i(32, 32)

const HeroCharacterScript := preload(
	"res://scenes/gameplay/hero/hero_character.gd"
)

@onready var hero_character: HeroCharacterScript = $World/HeroCharacter
@onready var hero_spawn: Marker2D = $World/HeroSpawn
@onready var player_camera: Camera2D = $World/HeroCharacter/PlayerCamera
@onready var development_hint: Label = $InterfaceLayer/DevelopmentHint

var _navigation_requested := false


func _ready() -> void:
	hero_character.global_position = hero_spawn.global_position
	hero_character.set_appearance_height(HERO_HEIGHT)

	player_camera.limit_left = ROOM_LEFT
	player_camera.limit_top = ROOM_TOP
	player_camera.limit_right = ROOM_RIGHT
	player_camera.limit_bottom = ROOM_BOTTOM
	player_camera.zoom = Vector2(CAMERA_ZOOM, CAMERA_ZOOM)
	player_camera.position_smoothing_enabled = false
	player_camera.enabled = true
	player_camera.make_current()

	development_hint.visible = OS.is_debug_build()


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
		"HeroRoom failed to navigate to route '%s' with error %d."
		% [MAIN_MENU_ROUTE, navigation_error],
	)
