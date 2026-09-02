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

enum TextureFilterPreset {
	NEAREST,
	SOFT,
}

const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const TILE_GRID_PREVIEW_SCRIPT := preload("res://scenes/dev/tile_grid_preview.gd")
const WORLD_STATE_PREVIEW_SCRIPT := preload("res://scenes/dev/world_state_preview.gd")
const COLLISION_DEBUG_OVERLAY_SCRIPT := preload(
	"res://scenes/dev/collision_debug_overlay.gd"
)
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
const PIXEL_SNAP_TOGGLE_ACTION := &"dev_pixel_snap_toggle"
const TEXTURE_FILTER_TOGGLE_ACTION := &"dev_texture_filter_toggle"
const DIAGNOSTICS_TOGGLE_ACTION := &"dev_diagnostics_toggle"
const COLLISION_DEBUG_TOGGLE_ACTION := &"dev_collision_debug_toggle"
const CONTROLS_TOGGLE_ACTION := &"dev_controls_toggle"
const DIAGNOSTICS_UPDATE_INTERVAL := 0.2
const PIXEL_GRID_MAX_DENOMINATOR := 16
const PIXEL_GRID_ALIGNMENT_TOLERANCE := 0.001
const WORLD_LEFT := 0
const WORLD_TOP := 0
const WORLD_RIGHT := 3840
const WORLD_BOTTOM := 2160
const CAMERA_ZOOM_NAMES: Array[String] = ["Weit", "Mittel", "Nah"]
const CAMERA_ZOOM_VALUES: Array[float] = [0.75, 1.0, 1.5]
const CAMERA_ZOOM_IDS: Array[String] = ["wide", "medium", "near"]
const CAMERA_PROFILE_NAMES: Array[String] = [
	"Testlabor · Weit",
	"Welt/Dungeon · Kandidat",
	"Kleiner Innenraum · experimentell",
]
const HERO_SIZE_NAMES: Array[String] = ["Klein", "Mittel", "Groß"]
const HERO_SIZE_VALUES: Array[float] = [64.0, 80.0, 96.0]
const HERO_SIZE_IDS: Array[String] = ["small", "medium", "large"]
const TILE_SIZE_NAMES: Array[String] = ["Klein", "Mittel", "Groß"]
const TILE_SIZE_VALUES: Array[int] = [32, 48, 64]
const TILE_SIZE_IDS: Array[String] = ["small", "medium", "large"]
const WORLD_STATE_NAMES: Array[String] = ["Beschädigt", "Wiederhergestellt"]
const WORLD_STATE_IDS: Array[String] = ["damaged", "restored"]
const TEXTURE_FILTER_NAMES: Array[String] = ["Nearest-Neighbor", "Weich"]
const TEXTURE_FILTER_IDS: Array[String] = ["nearest", "soft"]
const TEXTURE_FILTER_VALUES: Array[int] = [
	CanvasItem.TEXTURE_FILTER_NEAREST,
	CanvasItem.TEXTURE_FILTER_LINEAR,
]

@onready var player_camera: Camera2D = $TestWorld/HeroCharacter/PlayerCamera
@onready var hero_visual: Node2D = $TestWorld/HeroCharacter/Visual
@onready var camera_status: Label = $InterfaceLayer/Interface/Text/CameraStatus
@onready var hero_character: HERO_SCRIPT = $TestWorld/HeroCharacter
@onready var hero_size_status: Label = $InterfaceLayer/Interface/Text/HeroSizeStatus
@onready var tile_grid_preview: TILE_GRID_PREVIEW_SCRIPT = (
	$TestWorld/TileComparison/TileGridPreview
)
@onready var tile_size_status: Label = $InterfaceLayer/Interface/Text/TileSizeStatus
@onready var world_state_preview: WORLD_STATE_PREVIEW_SCRIPT = $TestWorld/WorldStatePreview
@onready var world_state_status: Label = $InterfaceLayer/Interface/Text/WorldStateStatus
@onready var pixel_snap_button: Button = (
	$InterfaceLayer/Interface/Text/RenderingButtons/PixelSnapButton
)
@onready var texture_filter_button: Button = (
	$InterfaceLayer/Interface/Text/RenderingButtons/TextureFilterButton
)
@onready var window_size_status: Label = $InterfaceLayer/Interface/Text/WindowSizeStatus
@onready var diagnostics_panel: Panel = $InterfaceLayer/DiagnosticsPanel
@onready var diagnostics_values: Label = $InterfaceLayer/DiagnosticsPanel/Values
@onready var collision_debug_overlay: COLLISION_DEBUG_OVERLAY_SCRIPT = (
	$TestWorld/CollisionDebugOverlay
)
@onready var controls_panel: Panel = $InterfaceLayer/HudPanel
@onready var controls_interface: MarginContainer = $InterfaceLayer/Interface
@onready var controls_prompt: Label = $InterfaceLayer/ControlsPrompt
@onready var test_world: Node2D = $TestWorld

var _navigation_requested := false
var _diagnostics_elapsed := 0.0
var _selected_camera_zoom: int = CameraZoomPreset.NEAR
var _selected_hero_size: int = HeroSizePreset.MEDIUM
var _selected_tile_size: int = TileSizePreset.SMALL
var _selected_world_state: int = WorldStatePreset.DAMAGED
var _pixel_snap_enabled := false
var _selected_texture_filter: int = TextureFilterPreset.NEAREST
var _pixel_snap_viewport: Viewport
var _initial_viewport_pixel_snap := false
var _initial_viewport_vertex_snap := false
var _initial_camera_position := Vector2.ZERO
var _initial_hero_visual_position := Vector2.ZERO
var _initial_camera_top_level := false
var _initial_hero_visual_top_level := false
var _texture_filter_targets: Array[Sprite2D] = []
var _initial_texture_filters: Array[int] = []


func _ready() -> void:
	_pixel_snap_viewport = get_viewport()
	_initial_viewport_pixel_snap = _pixel_snap_viewport.snap_2d_transforms_to_pixel
	_initial_viewport_vertex_snap = _pixel_snap_viewport.snap_2d_vertices_to_pixel
	_initial_camera_position = player_camera.position
	_initial_hero_visual_position = hero_visual.position
	_initial_camera_top_level = player_camera.top_level
	_initial_hero_visual_top_level = hero_visual.top_level
	_collect_texture_filter_targets(test_world)
	pixel_snap_button.pressed.connect(_on_pixel_snap_button_pressed)
	texture_filter_button.pressed.connect(_on_texture_filter_button_pressed)
	player_camera.limit_left = WORLD_LEFT
	player_camera.limit_top = WORLD_TOP
	player_camera.limit_right = WORLD_RIGHT
	player_camera.limit_bottom = WORLD_BOTTOM
	player_camera.position_smoothing_enabled = false
	player_camera.enabled = true
	player_camera.make_current()
	diagnostics_panel.visible = false
	collision_debug_overlay.set_debug_visible(false)
	_set_controls_visible(false)
	resized.connect(_on_visual_lab_resized)
	get_window().size_changed.connect(_on_main_window_size_changed)
	_load_settings()
	_apply_camera_zoom()
	_apply_hero_size()
	_apply_tile_size()
	_apply_world_state()
	_apply_pixel_snap()
	_apply_texture_filter()
	_update_window_size_status()


func _exit_tree() -> void:
	if _pixel_snap_viewport != null and is_instance_valid(_pixel_snap_viewport):
		_pixel_snap_viewport.snap_2d_transforms_to_pixel = _initial_viewport_pixel_snap
		_pixel_snap_viewport.snap_2d_vertices_to_pixel = _initial_viewport_vertex_snap
	_restore_texture_filters()


func _process(delta: float) -> void:
	_update_pixel_snap_render_alignment()
	if not diagnostics_panel.visible:
		return
	_diagnostics_elapsed += delta
	if _diagnostics_elapsed < DIAGNOSTICS_UPDATE_INTERVAL:
		return
	_diagnostics_elapsed = 0.0
	_update_diagnostics_values()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(DIAGNOSTICS_TOGGLE_ACTION):
		get_viewport().set_input_as_handled()
		if not _is_repeated_key_event(event):
			_toggle_diagnostics()
		return
	if event.is_action_pressed(COLLISION_DEBUG_TOGGLE_ACTION):
		get_viewport().set_input_as_handled()
		if not _is_repeated_key_event(event):
			_toggle_collision_debug()
		return
	if event.is_action_pressed(CONTROLS_TOGGLE_ACTION):
		get_viewport().set_input_as_handled()
		if not _is_repeated_key_event(event):
			_set_controls_visible(not controls_panel.visible)
		return
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
	if event.is_action_pressed(PIXEL_SNAP_TOGGLE_ACTION):
		get_viewport().set_input_as_handled()
		if not _is_repeated_key_event(event):
			_toggle_pixel_snap()
		return
	if event.is_action_pressed(TEXTURE_FILTER_TOGGLE_ACTION):
		get_viewport().set_input_as_handled()
		if not _is_repeated_key_event(event):
			_toggle_texture_filter()
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
	_update_pixel_snap_render_alignment()
	var limited_suffix := ""
	if effective_zoom > selected_zoom:
		limited_suffix = " · durch Weltgröße begrenzt"
	camera_status.text = "Kamera: %s · %s×%s" % [
		CAMERA_ZOOM_NAMES[_selected_camera_zoom],
		_format_camera_zoom(effective_zoom),
		limited_suffix,
	]
	_refresh_diagnostics_if_visible()


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
	_refresh_diagnostics_if_visible()


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
	_refresh_diagnostics_if_visible()


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
	_refresh_diagnostics_if_visible()


func _toggle_pixel_snap() -> void:
	_set_pixel_snap_enabled(not _pixel_snap_enabled)
	_save_settings()


func _set_pixel_snap_enabled(pixel_snap_enabled: bool) -> void:
	_pixel_snap_enabled = pixel_snap_enabled
	_apply_pixel_snap()


func _apply_pixel_snap() -> void:
	_pixel_snap_viewport.snap_2d_transforms_to_pixel = _pixel_snap_enabled
	_pixel_snap_viewport.snap_2d_vertices_to_pixel = false
	_update_pixel_snap_render_alignment()
	pixel_snap_button.button_pressed = _pixel_snap_enabled
	pixel_snap_button.text = "Pixel-Snap: %s" % _pixel_snap_name()
	_refresh_diagnostics_if_visible()


func _toggle_texture_filter() -> void:
	var next_filter := TextureFilterPreset.SOFT
	if _selected_texture_filter == TextureFilterPreset.SOFT:
		next_filter = TextureFilterPreset.NEAREST
	_set_texture_filter(next_filter)
	_save_settings()


func _set_texture_filter(texture_filter: int) -> void:
	_selected_texture_filter = clampi(
		texture_filter,
		TextureFilterPreset.NEAREST,
		TextureFilterPreset.SOFT,
	)
	_apply_texture_filter()


func _apply_texture_filter() -> void:
	var selected_filter := TEXTURE_FILTER_VALUES[_selected_texture_filter]
	for sprite in _texture_filter_targets:
		if is_instance_valid(sprite):
			sprite.texture_filter = selected_filter as CanvasItem.TextureFilter
	texture_filter_button.button_pressed = (
		_selected_texture_filter == TextureFilterPreset.SOFT
	)
	texture_filter_button.text = "Texturfilter: %s" % _texture_filter_name()
	_refresh_diagnostics_if_visible()


func _collect_texture_filter_targets(node: Node) -> void:
	var sprite := node as Sprite2D
	if sprite != null and sprite.texture != null:
		_texture_filter_targets.append(sprite)
		_initial_texture_filters.append(sprite.texture_filter)
	for child in node.get_children():
		_collect_texture_filter_targets(child)


func _restore_texture_filters() -> void:
	for target_index in range(_texture_filter_targets.size()):
		var sprite := _texture_filter_targets[target_index]
		if is_instance_valid(sprite):
			sprite.texture_filter = (
				_initial_texture_filters[target_index] as CanvasItem.TextureFilter
			)


func _toggle_diagnostics() -> void:
	diagnostics_panel.visible = not diagnostics_panel.visible
	_diagnostics_elapsed = 0.0
	if diagnostics_panel.visible:
		_update_diagnostics_values()


func _toggle_collision_debug() -> void:
	collision_debug_overlay.set_debug_visible(not collision_debug_overlay.visible)


func _set_controls_visible(controls_visible: bool) -> void:
	controls_panel.visible = controls_visible
	controls_interface.visible = controls_visible
	controls_prompt.visible = not controls_visible
	if controls_visible:
		pixel_snap_button.grab_focus()
	else:
		if pixel_snap_button.has_focus():
			pixel_snap_button.release_focus()
		if texture_filter_button.has_focus():
			texture_filter_button.release_focus()


func _update_diagnostics_values() -> void:
	var player_position := hero_character.global_position
	var rendered_player_position := hero_visual.global_position
	var raw_camera_position := hero_character.to_global(_initial_camera_position)
	var rendered_camera_position := player_camera.global_position
	var camera_position := player_camera.get_screen_center_position()
	var world_position := test_world.global_position
	var tile_size := tile_grid_preview.tile_size
	var window_size := get_window().size
	var stretch_scale := _pixel_snap_viewport.get_stretch_transform().get_scale()
	diagnostics_values.text = "\n".join(
		[
			"FPS: %d" % maxi(0, roundi(Engine.get_frames_per_second())),
			"Spielerposition roh: %s" % _format_diagnostic_position(player_position),
			"Spielerposition gerundet: %s"
			% _format_rounded_diagnostic_position(rendered_player_position),
			"Kameraposition roh: %s"
			% _format_diagnostic_position(raw_camera_position),
			"Kameraposition gerastert: %s"
			% _format_rounded_diagnostic_position(rendered_camera_position),
			"Kamerazentrum: %s" % _format_diagnostic_position(camera_position),
			"Weltanker: %s" % _format_diagnostic_position(world_position),
			"Kameraprofil: %s" % CAMERA_PROFILE_NAMES[_selected_camera_zoom],
			"Kamera: %s×" % _format_camera_zoom(player_camera.zoom.x),
			"Figur: %d px" % roundi(hero_character.get_appearance_height()),
			"Tiles: %d × %d px" % [tile_size, tile_size],
			"Welt: %s" % WORLD_STATE_NAMES[_selected_world_state],
			"Pixel-Snap: %s" % _pixel_snap_name(),
			"Vertex-Snap: %s"
			% ("AN" if _pixel_snap_viewport.snap_2d_vertices_to_pixel else "AUS"),
			"Darstellungsraster: %s" % _pixel_snap_grid_name(),
			"Texturfilter: %s" % _texture_filter_name(),
			"Fenster: %d × %d" % [window_size.x, window_size.y],
			"Fensterskalierung: %s" % _format_stretch_scale(stretch_scale),
		]
	)


func _refresh_diagnostics_if_visible() -> void:
	if diagnostics_panel != null and diagnostics_panel.visible:
		_update_diagnostics_values()


func _is_repeated_key_event(event: InputEvent) -> bool:
	var echo_value: Variant = event.get("echo")
	return echo_value is bool and echo_value


func _load_settings() -> void:
	_selected_camera_zoom = CameraZoomPreset.NEAR
	_selected_hero_size = HeroSizePreset.MEDIUM
	_selected_tile_size = TileSizePreset.SMALL
	_selected_world_state = WorldStatePreset.DAMAGED
	_pixel_snap_enabled = false
	_selected_texture_filter = TextureFilterPreset.NEAREST

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
		HeroSizePreset.MEDIUM,
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
	_pixel_snap_enabled = _read_bool_setting(settings, "pixel_snap", false)
	_selected_texture_filter = _read_preset_index(
		settings,
		"texture_filter",
		TEXTURE_FILTER_IDS,
		TextureFilterPreset.NEAREST,
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
	settings.set_value(SETTINGS_SECTION, "pixel_snap", _pixel_snap_enabled)
	settings.set_value(
		SETTINGS_SECTION,
		"texture_filter",
		TEXTURE_FILTER_IDS[_selected_texture_filter],
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


func _read_bool_setting(
	settings: ConfigFile,
	setting_key: String,
	default_value: bool,
) -> bool:
	var stored_value: Variant = settings.get_value(
		SETTINGS_SECTION,
		setting_key,
		default_value,
	)
	if not stored_value is bool:
		return default_value
	return bool(stored_value)


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


func _format_diagnostic_position(position: Vector2) -> String:
	return "x=%s · y=%s" % [
		_format_position_component(position.x),
		_format_position_component(position.y),
	]


func _format_position_component(value: float) -> String:
	return ("%.3f" % value).replace(".", ",")


func _format_rounded_diagnostic_position(position: Vector2) -> String:
	return "x=%d · y=%d" % [roundi(position.x), roundi(position.y)]


func _pixel_snap_name() -> String:
	return "AN" if _pixel_snap_enabled else "AUS"


func _texture_filter_name() -> String:
	return TEXTURE_FILTER_NAMES[_selected_texture_filter]


func _update_pixel_snap_render_alignment() -> void:
	if not _pixel_snap_enabled:
		var camera_was_aligned := not player_camera.position.is_equal_approx(
			_initial_camera_position
		) or player_camera.top_level != _initial_camera_top_level
		player_camera.top_level = _initial_camera_top_level
		hero_visual.top_level = _initial_hero_visual_top_level
		player_camera.position = _initial_camera_position
		hero_visual.position = _initial_hero_visual_position
		if camera_was_aligned:
			player_camera.force_update_scroll()
		return

	var world_grid_step := _pixel_snap_world_grid_step()
	var raw_camera_position := hero_character.to_global(_initial_camera_position)
	var raw_visual_position := hero_character.to_global(_initial_hero_visual_position)
	var rendered_camera_position := _snap_position_to_grid(
		raw_camera_position,
		world_grid_step,
	)
	var rendered_visual_position := _snap_position_to_grid(
		raw_visual_position,
		world_grid_step,
	)
	player_camera.top_level = true
	hero_visual.top_level = true
	player_camera.global_position = rendered_camera_position
	hero_visual.global_position = rendered_visual_position
	player_camera.force_update_scroll()


func _pixel_snap_world_grid_step() -> Vector2:
	var stretch_scale := _pixel_snap_viewport.get_stretch_transform().get_scale()
	var camera_grid_step := Vector2i(
		roundi(_world_grid_step_for_output_scale(player_camera.zoom.x)),
		roundi(_world_grid_step_for_output_scale(player_camera.zoom.y)),
	)
	var output_grid_step := Vector2i(
		roundi(
			_world_grid_step_for_output_scale(
				player_camera.zoom.x * absf(stretch_scale.x)
			)
		),
		roundi(
			_world_grid_step_for_output_scale(
				player_camera.zoom.y * absf(stretch_scale.y)
			)
		),
	)
	return Vector2(
		_least_common_multiple(camera_grid_step.x, output_grid_step.x),
		_least_common_multiple(camera_grid_step.y, output_grid_step.y),
	)


func _world_grid_step_for_output_scale(output_scale: float) -> float:
	if output_scale <= 0.0:
		return 1.0
	for denominator in range(1, PIXEL_GRID_MAX_DENOMINATOR + 1):
		var scaled_value := output_scale * float(denominator)
		if absf(scaled_value - roundf(scaled_value)) <= PIXEL_GRID_ALIGNMENT_TOLERANCE:
			return float(denominator)
	return 1.0


func _least_common_multiple(left: int, right: int) -> int:
	var first := maxi(1, left)
	var second := maxi(1, right)
	return first * second / _greatest_common_divisor(first, second)


func _greatest_common_divisor(left: int, right: int) -> int:
	var first := absi(left)
	var second := absi(right)
	while second != 0:
		var remainder := first % second
		first = second
		second = remainder
	return maxi(1, first)


func _snap_position_to_grid(position: Vector2, grid_step: Vector2) -> Vector2:
	return Vector2(
		snappedf(position.x, grid_step.x),
		snappedf(position.y, grid_step.y),
	)


func _pixel_snap_grid_name() -> String:
	if not _pixel_snap_enabled:
		return "frei"
	var grid_step := _pixel_snap_world_grid_step()
	return "%d × %d Weltpixel" % [roundi(grid_step.x), roundi(grid_step.y)]


func _format_stretch_scale(stretch_scale: Vector2) -> String:
	if is_equal_approx(stretch_scale.x, stretch_scale.y):
		return "%s×" % _format_camera_zoom(stretch_scale.x)
	return "x=%s× · y=%s×" % [
		_format_camera_zoom(stretch_scale.x),
		_format_camera_zoom(stretch_scale.y),
	]


func _update_window_size_status() -> void:
	var window_size := get_window().size
	window_size_status.text = "Fenster: %d × %d" % [window_size.x, window_size.y]
	_refresh_diagnostics_if_visible()


func _on_visual_lab_resized() -> void:
	_apply_camera_zoom()


func _on_main_window_size_changed() -> void:
	_update_window_size_status()


func _on_pixel_snap_button_pressed() -> void:
	_set_pixel_snap_enabled(pixel_snap_button.button_pressed)
	_save_settings()


func _on_texture_filter_button_pressed() -> void:
	var selected_filter := TextureFilterPreset.NEAREST
	if texture_filter_button.button_pressed:
		selected_filter = TextureFilterPreset.SOFT
	_set_texture_filter(selected_filter)
	_save_settings()
