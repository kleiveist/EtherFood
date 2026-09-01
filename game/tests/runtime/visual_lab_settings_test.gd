extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const TILE_GRID_PREVIEW_SCRIPT := preload("res://scenes/dev/tile_grid_preview.gd")
const SETTINGS_PATH_PROJECT_KEY := "etherfood/development/visual_lab_settings_path"
const SETTINGS_TEST_PATH := "user://visual_lab_settings_test.cfg"
const ZOOM_OUT_ACTION := &"dev_camera_zoom_out"
const HERO_SIZE_INCREASE_ACTION := &"dev_hero_size_increase"
const TILE_SIZE_INCREASE_ACTION := &"dev_tile_size_increase"
const NEAR_STATUS := "Kamera: Nah · 1,50×"
const MEDIUM_ZOOM_STATUS := "Kamera: Mittel · 1,00×"
const SMALL_HERO_STATUS := "Figur: Klein · 64 Weltpixel"
const MEDIUM_HERO_STATUS := "Figur: Mittel · 80 Weltpixel"
const SMALL_TILE_STATUS := "Tiles: Klein · 32 × 32 Weltpixel"
const MEDIUM_TILE_STATUS := "Tiles: Mittel · 48 × 48 Weltpixel"

var failures: PackedStringArray = []
var _had_settings_path_override := false
var _original_settings_path: Variant = null


func run(tree: SceneTree) -> PackedStringArray:
	_remember_and_set_test_path()
	_remove_test_settings()

	var visual_lab_scene := load(VISUAL_LAB_SCENE_PATH) as PackedScene
	_expect(visual_lab_scene != null, "VisualLab scene loads")
	if visual_lab_scene == null:
		_cleanup_test_path()
		return failures

	var visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	if visual_lab == null:
		_cleanup_test_path()
		return failures

	_expect(
		not FileAccess.file_exists(SETTINGS_TEST_PATH),
		"missing settings file remains optional",
	)
	_expect_visual_lab_state(
		visual_lab,
		Vector2(1.5, 1.5),
		64.0,
		32,
		NEAR_STATUS,
		SMALL_HERO_STATUS,
		SMALL_TILE_STATUS,
		"missing file uses near, small, and small defaults",
	)

	visual_lab._unhandled_input(_pressed_action(ZOOM_OUT_ACTION))
	_expect_saved_settings(
		"medium",
		"small",
		"small",
		"camera change saves immediately",
	)
	visual_lab._unhandled_input(_pressed_action(HERO_SIZE_INCREASE_ACTION))
	_expect_saved_settings(
		"medium",
		"medium",
		"small",
		"hero-size change saves immediately",
	)
	visual_lab._unhandled_input(_pressed_action(TILE_SIZE_INCREASE_ACTION))
	_expect_saved_settings(
		"medium",
		"medium",
		"medium",
		"tile-size change saves immediately",
	)
	_expect_visual_lab_state(
		visual_lab,
		Vector2.ONE,
		80.0,
		48,
		MEDIUM_ZOOM_STATUS,
		MEDIUM_HERO_STATUS,
		MEDIUM_TILE_STATUS,
		"changed instance displays all medium presets",
	)
	await _close_visual_lab(tree, visual_lab)

	var reopened_visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	if reopened_visual_lab != null:
		_expect_visual_lab_state(
			reopened_visual_lab,
			Vector2.ONE,
			80.0,
			48,
			MEDIUM_ZOOM_STATUS,
			MEDIUM_HERO_STATUS,
			MEDIUM_TILE_STATUS,
			"new instance loads all saved presets and status texts",
		)
		await _close_visual_lab(tree, reopened_visual_lab)

	_write_settings(1, "invalid-camera", 12, "invalid-tiles")
	var invalid_visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	if invalid_visual_lab != null:
		_expect_visual_lab_state(
			invalid_visual_lab,
			Vector2(1.5, 1.5),
			64.0,
			32,
			NEAR_STATUS,
			SMALL_HERO_STATUS,
			SMALL_TILE_STATUS,
			"invalid preset values fall back to safe defaults",
		)
		await _close_visual_lab(tree, invalid_visual_lab)

	_write_settings(2, "wide", "large", "large")
	var future_version_visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	if future_version_visual_lab != null:
		_expect_visual_lab_state(
			future_version_visual_lab,
			Vector2(1.5, 1.5),
			64.0,
			32,
			NEAR_STATUS,
			SMALL_HERO_STATUS,
			SMALL_TILE_STATUS,
			"unsupported settings version uses safe defaults",
		)
		await _close_visual_lab(tree, future_version_visual_lab)

	_write_corrupted_settings()
	var corrupted_visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	_expect(corrupted_visual_lab != null, "corrupted settings do not prevent instantiation")
	if corrupted_visual_lab != null:
		_expect_visual_lab_state(
			corrupted_visual_lab,
			Vector2(1.5, 1.5),
			64.0,
			32,
			NEAR_STATUS,
			SMALL_HERO_STATUS,
			SMALL_TILE_STATUS,
			"corrupted settings use safe defaults without crashing",
		)
		await _close_visual_lab(tree, corrupted_visual_lab)

	_cleanup_test_path()
	return failures


func _open_visual_lab(tree: SceneTree, visual_lab_scene: PackedScene) -> Control:
	var visual_lab_node := visual_lab_scene.instantiate()
	_expect(visual_lab_node is Control, "VisualLab instantiates as Control")
	if not visual_lab_node is Control:
		if visual_lab_node != null:
			visual_lab_node.free()
		return null
	var visual_lab := visual_lab_node as Control
	tree.root.add_child(visual_lab)
	await tree.process_frame
	return visual_lab


func _close_visual_lab(tree: SceneTree, visual_lab: Control) -> void:
	visual_lab.queue_free()
	await tree.process_frame


func _expect_visual_lab_state(
	visual_lab: Control,
	expected_zoom: Vector2,
	expected_hero_height: float,
	expected_tile_size: int,
	expected_camera_status: String,
	expected_hero_status: String,
	expected_tile_status: String,
	description: String,
) -> void:
	var player_camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var hero: HERO_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter"
	) as HERO_SCRIPT
	var tile_grid_preview: TILE_GRID_PREVIEW_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/TileComparison/TileGridPreview"
	) as TILE_GRID_PREVIEW_SCRIPT
	var camera_status := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/CameraStatus"
	) as Label
	var hero_status := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/HeroSizeStatus"
	) as Label
	var tile_status := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/TileSizeStatus"
	) as Label

	_expect(player_camera != null, "%s: PlayerCamera exists" % description)
	_expect(hero != null, "%s: HeroCharacter exists" % description)
	_expect(tile_grid_preview != null, "%s: TileGridPreview exists" % description)
	_expect(camera_status != null, "%s: camera status exists" % description)
	_expect(hero_status != null, "%s: hero status exists" % description)
	_expect(tile_status != null, "%s: tile status exists" % description)
	if (
		player_camera == null
		or hero == null
		or tile_grid_preview == null
		or camera_status == null
		or hero_status == null
		or tile_status == null
	):
		return

	_expect(
		player_camera.zoom.is_equal_approx(expected_zoom),
		"%s: camera zoom" % description,
	)
	_expect(
		is_equal_approx(hero.get_appearance_height(), expected_hero_height),
		"%s: hero height" % description,
	)
	_expect(
		tile_grid_preview.tile_size == expected_tile_size,
		"%s: tile size" % description,
	)
	_expect(
		camera_status.text == expected_camera_status,
		"%s: camera status text" % description,
	)
	_expect(
		hero_status.text == expected_hero_status,
		"%s: hero status text" % description,
	)
	_expect(
		tile_status.text == expected_tile_status,
		"%s: tile status text" % description,
	)


func _expect_saved_settings(
	expected_camera_id: String,
	expected_hero_id: String,
	expected_tile_id: String,
	description: String,
) -> void:
	var settings := ConfigFile.new()
	_expect(settings.load(SETTINGS_TEST_PATH) == OK, "%s: file loads" % description)
	_expect(
		settings.get_value("meta", "version", 0) == 1,
		"%s: version is stored" % description,
	)
	_expect(
		settings.get_value("visual_lab", "camera_zoom", "") == expected_camera_id,
		"%s: camera ID" % description,
	)
	_expect(
		settings.get_value("visual_lab", "hero_size", "") == expected_hero_id,
		"%s: hero-size ID" % description,
	)
	_expect(
		settings.get_value("visual_lab", "tile_size", "") == expected_tile_id,
		"%s: tile-size ID" % description,
	)


func _write_settings(
	version: int,
	camera_zoom: Variant,
	hero_size: Variant,
	tile_size: Variant,
) -> void:
	var settings := ConfigFile.new()
	settings.set_value("meta", "version", version)
	settings.set_value("visual_lab", "camera_zoom", camera_zoom)
	settings.set_value("visual_lab", "hero_size", hero_size)
	settings.set_value("visual_lab", "tile_size", tile_size)
	_expect(settings.save(SETTINGS_TEST_PATH) == OK, "test settings can be written")


func _write_corrupted_settings() -> void:
	var settings_file := FileAccess.open(SETTINGS_TEST_PATH, FileAccess.WRITE)
	_expect(settings_file != null, "corrupted test fixture can be written")
	if settings_file == null:
		return
	settings_file.store_string("[meta\nversion=1\n[visual_lab]\ncamera_zoom=\"near\"")
	settings_file.close()


func _remember_and_set_test_path() -> void:
	_had_settings_path_override = ProjectSettings.has_setting(SETTINGS_PATH_PROJECT_KEY)
	if _had_settings_path_override:
		_original_settings_path = ProjectSettings.get_setting(SETTINGS_PATH_PROJECT_KEY)
	ProjectSettings.set_setting(SETTINGS_PATH_PROJECT_KEY, SETTINGS_TEST_PATH)
	_expect(
		ProjectSettings.get_setting(SETTINGS_PATH_PROJECT_KEY) == SETTINGS_TEST_PATH,
		"VisualLab settings tests use only the isolated test path",
	)


func _cleanup_test_path() -> void:
	_remove_test_settings()
	if _had_settings_path_override:
		ProjectSettings.set_setting(SETTINGS_PATH_PROJECT_KEY, _original_settings_path)
		return
	ProjectSettings.set_setting(SETTINGS_PATH_PROJECT_KEY, null)


func _remove_test_settings() -> void:
	if not FileAccess.file_exists(SETTINGS_TEST_PATH):
		return
	var remove_error := DirAccess.remove_absolute(
		ProjectSettings.globalize_path(SETTINGS_TEST_PATH)
	)
	_expect(remove_error == OK, "isolated test settings can be removed")


func _pressed_action(action: StringName) -> InputEventAction:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	return event


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLabSettings: %s" % description)
