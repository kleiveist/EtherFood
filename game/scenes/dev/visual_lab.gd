extends Control

enum CameraZoomPreset {
	WIDE,
	MEDIUM,
	NEAR,
}

enum HeroSizePreset {
	SMALL,
	MEDIUM,
	LARGE,
}

enum TileSizePreset {
	SMALL,
	MEDIUM,
	LARGE,
}

enum WorldStatePreset {
	DAMAGED,
	RESTORED,
}

const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const TILE_GRID_PREVIEW_SCRIPT := preload("res://scenes/dev/tile_grid_preview.gd")
const WORLD_STATE_PREVIEW_SCRIPT := preload("res://scenes/dev/world_state_preview.gd")
const MAIN_MENU_ROUTE := &"main_menu"
const SETTINGS_VERSION := 1
const DEFAULT_SETTINGS_PATH := "user://visual_lab_settings.cfg"
const SETTINGS_PATH_PROJECT_KEY := "etherfood/development/visual_lab_settings_path"
const SETTINGS_META_SECTION := "meta"
const SETTINGS_SECTION := "visual_lab"
const ZOOM_OUT_ACTION := &"dev_camera_zoom_out"
const ZOOM_IN_ACTION := &"dev_camera_zoom_in"
const HERO_SIZE_DECREASE_ACTION := &"dev_hero_size_decrease"
const HERO_SIZE_INCREASE_ACTION := &"dev_hero_size_increase"
const TILE_SIZE_DECREASE_ACTION := &"dev_tile_size_decrease"
const TILE_SIZE_INCREASE_ACTION := &"dev_tile_size_increase"
const WORLD_STATE_TOGGLE_ACTION := &"dev_world_state_toggle"
const WORLD_LEFT := 0
const WORLD_TOP := 0
const WORLD_RIGHT := 3840
const WORLD_BOTTOM := 2160
const CAMERA_ZOOM_NAMES: Array[String] = ["Weit", "Mittel", "Nah"]
const CAMERA_ZOOM_VALUES: Array[float] = [0.75, 1.0, 1.5]
const CAMERA_ZOOM_IDS: Array[String] = ["wide", "medium", "near"]
const HERO_SIZE_NAMES: Array[String] = ["Klein", "Mittel", "Groß"]
const HERO_SIZE_VALUES: Array[float] = [64.0, 80.0, 96.0]
const HERO_SIZE_IDS: Array[String] = ["small", "medium", "large"]
const TILE_SIZE_NAMES: Array[String] = ["Klein", "Mittel", "Groß"]
const TILE_SIZE_VALUES: Array[int] = [32, 48, 64]
const TILE_SIZE_IDS: Array[String] = ["small", "medium", "large"]
const WORLD_STATE_NAMES: Array[String] = ["Beschädigt", "Wiederhergestellt"]
const WORLD_STATE_IDS: Array[String] = ["damaged", "restored"]

@onready var player_camera: Camera2D = $TestWorld/HeroCharacter/PlayerCamera
@onready var camera_status: Label = $InterfaceLayer/Interface/Text/CameraStatus
@onready var hero_character: HERO_SCRIPT = $TestWorld/HeroCharacter
@onready var hero_size_status: Label = $InterfaceLayer/Interface/Text/HeroSizeStatus
@onready var tile_grid_preview: TILE_GRID_PREVIEW_SCRIPT = (
	$TestWorld/TileComparison/TileGridPreview
)
@onready var tile_size_status: Label = $InterfaceLayer/Interface/Text/TileSizeStatus
@onready var world_state_preview: WORLD_STATE_PREVIEW_SCRIPT = $TestWorld/WorldStatePreview
@onready var world_state_status: Label = $InterfaceLayer/Interface/Text/WorldStateStatus
@onready var window_size_status: Label = $InterfaceLayer/Interface/Text/WindowSizeStatus

var _navigation_requested := false
var _selected_camera_zoom: int = CameraZoomPreset.NEAR
var _selected_hero_size: int = HeroSizePreset.SMALL
var _selected_tile_size: int = TileSizePreset.SMALL
var _selected_world_state: int = WorldStatePreset.DAMAGED


func _ready() -> void:
	player_camera.limit_left = WORLD_LEFT
	player_camera.limit_top = WORLD_TOP
	player_camera.limit_right = WORLD_RIGHT
	player_camera.limit_bottom = WORLD_BOTTOM
	player_camera.position_smoothing_enabled = false
	player_camera.enabled = true
	player_camera.make_current()
	resized.connect(_on_visual_lab_resized)
	get_window().size_changed.connect(_on_main_window_size_changed)
	_load_settings()
	_apply_camera_zoom()
	_apply_hero_size()
	_apply_tile_size()
	_apply_world_state()
	_update_window_size_status()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(ZOOM_OUT_ACTION):
		get_viewport().set_input_as_handled()
		_change_camera_zoom(-1)
		return
	if event.is_action_pressed(ZOOM_IN_ACTION):
		get_viewport().set_input_as_handled()
		_change_camera_zoom(1)
		return
	if event.is_action_pressed(HERO_SIZE_DECREASE_ACTION):
		get_viewport().set_input_as_handled()
		_change_hero_size(-1)
		return
	if event.is_action_pressed(HERO_SIZE_INCREASE_ACTION):
		get_viewport().set_input_as_handled()
		_change_hero_size(1)
		return
	if event.is_action_pressed(TILE_SIZE_DECREASE_ACTION):
		get_viewport().set_input_as_handled()
		_change_tile_size(-1)
		return
	if event.is_action_pressed(TILE_SIZE_INCREASE_ACTION):
		get_viewport().set_input_as_handled()
		_change_tile_size(1)
		return
	if event.is_action_pressed(WORLD_STATE_TOGGLE_ACTION):
		get_viewport().set_input_as_handled()
		_toggle_world_state()
		return
	if _navigation_requested or not event.is_action_pressed(&"ui_cancel"):
		return

	get_viewport().set_input_as_handled()
	_navigation_requested = true
	_save_settings()
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
	_save_settings()


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


func _change_hero_size(direction: int) -> void:
	var next_size := clampi(
		_selected_hero_size + direction,
		HeroSizePreset.SMALL,
		HeroSizePreset.LARGE,
	)
	if next_size == _selected_hero_size:
		return
	_selected_hero_size = next_size
	_apply_hero_size()
	_save_settings()


func _apply_hero_size() -> void:
	var selected_height := HERO_SIZE_VALUES[_selected_hero_size]
	hero_character.set_appearance_height(selected_height)
	hero_size_status.text = "Figur: %s · %d Weltpixel" % [
		HERO_SIZE_NAMES[_selected_hero_size],
		roundi(hero_character.get_appearance_height()),
	]


func _change_tile_size(direction: int) -> void:
	var next_size := clampi(
		_selected_tile_size + direction,
		TileSizePreset.SMALL,
		TileSizePreset.LARGE,
	)
	if next_size == _selected_tile_size:
		return
	_selected_tile_size = next_size
	_apply_tile_size()
	_save_settings()


func _apply_tile_size() -> void:
	var selected_size := TILE_SIZE_VALUES[_selected_tile_size]
	tile_grid_preview.set_tile_size(selected_size)
	tile_size_status.text = "Tiles: %s · %d × %d Weltpixel" % [
		TILE_SIZE_NAMES[_selected_tile_size],
		selected_size,
		selected_size,
	]


func _toggle_world_state() -> void:
	if _selected_world_state == WorldStatePreset.DAMAGED:
		_selected_world_state = WorldStatePreset.RESTORED
	else:
		_selected_world_state = WorldStatePreset.DAMAGED
	_apply_world_state()
	_save_settings()


func _apply_world_state() -> void:
	world_state_preview.set_world_state(_selected_world_state)
	world_state_status.text = "Weltzustand: %s" % WORLD_STATE_NAMES[_selected_world_state]


func _load_settings() -> void:
	_selected_camera_zoom = CameraZoomPreset.NEAR
	_selected_hero_size = HeroSizePreset.SMALL
	_selected_tile_size = TileSizePreset.SMALL
	_selected_world_state = WorldStatePreset.DAMAGED

	var settings := ConfigFile.new()
	var load_error := settings.load(_settings_path())
	if load_error == ERR_FILE_NOT_FOUND:
		return
	if load_error != OK:
		push_warning("VisualLab could not load its settings (error %d)." % load_error)
		return
	var stored_version: Variant = settings.get_value(SETTINGS_META_SECTION, "version", 0)
	if not stored_version is int or stored_version != SETTINGS_VERSION:
		return

	_selected_camera_zoom = _read_preset_index(
		settings,
		"camera_zoom",
		CAMERA_ZOOM_IDS,
		CameraZoomPreset.NEAR,
	)
	_selected_hero_size = _read_preset_index(
		settings,
		"hero_size",
		HERO_SIZE_IDS,
		HeroSizePreset.SMALL,
	)
	_selected_tile_size = _read_preset_index(
		settings,
		"tile_size",
		TILE_SIZE_IDS,
		TileSizePreset.SMALL,
	)
	_selected_world_state = _read_preset_index(
		settings,
		"world_state",
		WORLD_STATE_IDS,
		WorldStatePreset.DAMAGED,
	)


func _save_settings() -> void:
	var settings := ConfigFile.new()
	settings.set_value(SETTINGS_META_SECTION, "version", SETTINGS_VERSION)
	settings.set_value(
		SETTINGS_SECTION,
		"camera_zoom",
		CAMERA_ZOOM_IDS[_selected_camera_zoom],
	)
	settings.set_value(
		SETTINGS_SECTION,
		"hero_size",
		HERO_SIZE_IDS[_selected_hero_size],
	)
	settings.set_value(
		SETTINGS_SECTION,
		"tile_size",
		TILE_SIZE_IDS[_selected_tile_size],
	)
	settings.set_value(
		SETTINGS_SECTION,
		"world_state",
		WORLD_STATE_IDS[_selected_world_state],
	)
	var save_error := settings.save(_settings_path())
	if save_error != OK:
		push_warning("VisualLab could not save its settings (error %d)." % save_error)


func _read_preset_index(
	settings: ConfigFile,
	setting_key: String,
	preset_ids: Array[String],
	default_index: int,
) -> int:
	var stored_id: Variant = settings.get_value(SETTINGS_SECTION, setting_key, "")
	if not stored_id is String:
		return default_index
	var preset_index := preset_ids.find(str(stored_id))
	return preset_index if preset_index >= 0 else default_index


func _settings_path() -> String:
	return str(
		ProjectSettings.get_setting(
			SETTINGS_PATH_PROJECT_KEY,
			DEFAULT_SETTINGS_PATH,
		)
	)


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


func _update_window_size_status() -> void:
	var window_size := get_window().size
	window_size_status.text = "Fenster: %d × %d" % [window_size.x, window_size.y]


func _on_visual_lab_resized() -> void:
	_apply_camera_zoom()


func _on_main_window_size_changed() -> void:
	_update_window_size_status()
