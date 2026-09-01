extends RefCounted

const WORLD_STATE_SCENE_PATH := "res://scenes/dev/world_state_preview.tscn"
const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const WORLD_STATE_PREVIEW_SCRIPT := preload("res://scenes/dev/world_state_preview.gd")
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const TILE_GRID_PREVIEW_SCRIPT := preload("res://scenes/dev/tile_grid_preview.gd")
const TOGGLE_ACTION := &"dev_world_state_toggle"
const SETTINGS_PATH_PROJECT_KEY := "etherfood/development/visual_lab_settings_path"
const SETTINGS_TEST_PATH := "user://visual_lab_settings_test.cfg"
const DAMAGED_STATUS := "Weltzustand: Beschädigt"
const RESTORED_STATUS := "Weltzustand: Wiederhergestellt"
const DAMAGED_CHILDREN: Array[String] = [
	"Ground",
	"BrokenBuilding",
	"DeadPlants",
	"Fog",
	"ColdLight",
]
const RESTORED_CHILDREN: Array[String] = [
	"Ground",
	"RepairedBuilding",
	"LivingPlants",
	"ClearAir",
	"WarmLight",
]

var failures: PackedStringArray = []
var _had_settings_path_override := false
var _original_settings_path: Variant = null


func run(tree: SceneTree) -> PackedStringArray:
	_remember_and_set_test_path()
	_remove_test_settings()
	_expect_input_mapping()
	await _expect_preview_scene_contract(tree)
	await _expect_visual_lab_contract(tree)
	_cleanup_test_path()
	return failures


func _expect_preview_scene_contract(tree: SceneTree) -> void:
	var preview_scene := load(WORLD_STATE_SCENE_PATH) as PackedScene
	_expect(preview_scene != null, "WorldStatePreview scene loads")
	if preview_scene == null:
		return
	var preview_node := preview_scene.instantiate()
	_expect(
		preview_node is WORLD_STATE_PREVIEW_SCRIPT,
		"WorldStatePreview uses its production script",
	)
	if not preview_node is WORLD_STATE_PREVIEW_SCRIPT:
		if preview_node != null:
			preview_node.free()
		return
	var preview: WORLD_STATE_PREVIEW_SCRIPT = preview_node as WORLD_STATE_PREVIEW_SCRIPT
	tree.root.add_child(preview)
	await tree.process_frame

	var damaged_state := preview.get_node_or_null("DamagedState") as Node2D
	var restored_state := preview.get_node_or_null("RestoredState") as Node2D
	var title := preview.get_node_or_null("Title") as Label
	_expect(damaged_state != null, "WorldStatePreview has DamagedState")
	_expect(restored_state != null, "WorldStatePreview has RestoredState")
	_expect(title != null, "WorldStatePreview has a Title")
	if damaged_state != null:
		for child_name in DAMAGED_CHILDREN:
			_expect(
				damaged_state.get_node_or_null(child_name) is CanvasItem,
				"DamagedState has visible test element %s" % child_name,
			)
	if restored_state != null:
		for child_name in RESTORED_CHILDREN:
			_expect(
				restored_state.get_node_or_null(child_name) is CanvasItem,
				"RestoredState has visible test element %s" % child_name,
			)
	if title != null:
		_expect(
			title.text == "Weltzustand · Beschädigt ↔ Wiederhergestellt",
			"WorldStatePreview title identifies both states",
		)

	_expect_preview_state(preview, false, "preview starts damaged")
	preview.set_world_state(preview.WorldState.RESTORED)
	_expect_preview_state(preview, true, "setting restored shows only RestoredState")
	preview.set_world_state(preview.WorldState.DAMAGED)
	_expect_preview_state(preview, false, "setting damaged shows only DamagedState")
	_expect(
		preview.find_children("*", "CollisionObject2D", true, false).is_empty(),
		"WorldStatePreview contains no collision bodies or areas",
	)
	_expect(
		preview.find_children("*", "CollisionShape2D", true, false).is_empty(),
		"WorldStatePreview contains no collision shapes",
	)
	_expect(
		preview.find_children("*", "CollisionPolygon2D", true, false).is_empty(),
		"WorldStatePreview contains no collision polygons",
	)

	var damaged_ground := preview.get_node_or_null("DamagedState/Ground") as Polygon2D
	var restored_ground := preview.get_node_or_null("RestoredState/Ground") as Polygon2D
	_expect(
		damaged_ground != null
		and restored_ground != null
		and damaged_ground.color != restored_ground.color,
		"damaged and restored ground colors are visibly distinct",
	)

	preview.queue_free()
	await tree.process_frame


func _expect_visual_lab_contract(tree: SceneTree) -> void:
	var visual_lab_scene := load(VISUAL_LAB_SCENE_PATH) as PackedScene
	_expect(visual_lab_scene != null, "VisualLab scene loads")
	if visual_lab_scene == null:
		return
	var visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	if visual_lab == null:
		return

	var preview: WORLD_STATE_PREVIEW_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/WorldStatePreview"
	) as WORLD_STATE_PREVIEW_SCRIPT
	var status := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/WorldStateStatus"
	) as Label
	var hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/WorldStateToggleHint"
	) as Label
	var player_camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var hero: HERO_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter"
	) as HERO_SCRIPT
	var tile_grid_preview: TILE_GRID_PREVIEW_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/TileComparison/TileGridPreview"
	) as TILE_GRID_PREVIEW_SCRIPT
	var hero_collision := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/CollisionShape2D"
	) as CollisionShape2D

	_expect(preview != null, "VisualLab contains WorldStatePreview")
	_expect(status != null, "VisualLab has a world-state status Label")
	_expect(
		hint != null and hint.text == "V / Controller-A: Zustand wechseln",
		"VisualLab shows the world-state controls",
	)
	_expect(player_camera != null, "VisualLab retains PlayerCamera")
	_expect(hero != null, "VisualLab retains HeroCharacter")
	_expect(tile_grid_preview != null, "VisualLab retains TileGridPreview")
	_expect(
		hero_collision != null and hero_collision.shape != null,
		"VisualLab retains the hero collision shape",
	)
	if (
		preview == null
		or status == null
		or player_camera == null
		or hero == null
		or tile_grid_preview == null
		or hero_collision == null
		or hero_collision.shape == null
	):
		await _close_visual_lab(tree, visual_lab)
		return

	_expect(
		preview.position == Vector2(2920, 820),
		"WorldStatePreview occupies the right side of TestWorld",
	)
	var preview_bounds := Rect2(preview.position, Vector2(720, 420))
	_expect(
		Rect2(0, 0, 3840, 2160).encloses(preview_bounds),
		"WorldStatePreview stays inside the enlarged TestWorld",
	)
	_expect(
		not preview_bounds.intersects(Rect2(1536, 220, 768, 384)),
		"WorldStatePreview does not cover TileComparison",
	)
	_expect(
		not preview_bounds.has_point(hero.position),
		"WorldStatePreview does not cover the hero start",
	)

	var original_camera_zoom := player_camera.zoom
	var original_hero_height := hero.get_appearance_height()
	var original_hero_position := hero.position
	var original_move_speed := hero.move_speed
	var original_tile_size := tile_grid_preview.tile_size
	var original_collision_shape := hero_collision.shape
	var original_collision_transform := hero_collision.transform

	_expect_preview_state(preview, false, "VisualLab starts with damaged world state")
	_expect(status.text == DAMAGED_STATUS, "damaged start state has matching HUD text")
	visual_lab._unhandled_input(_pressed_key(KEY_V, true))
	_expect_preview_state(preview, false, "held toggle input does not repeat")

	visual_lab._unhandled_input(_pressed_key(KEY_V))
	_expect_preview_state(preview, true, "V changes damaged state to restored")
	_expect(status.text == RESTORED_STATUS, "restored state has matching HUD text")
	_expect_saved_world_state("restored")
	visual_lab._unhandled_input(_pressed_key(KEY_V))
	_expect_preview_state(preview, false, "second V press restores damaged state")
	_expect(status.text == DAMAGED_STATUS, "second V press updates the HUD")
	_expect_saved_world_state("damaged")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_A))
	_expect_preview_state(preview, true, "Controller-A changes damaged state to restored")
	_expect(status.text == RESTORED_STATUS, "controller toggle updates the HUD")
	_expect_saved_world_state("restored")

	_expect(
		player_camera.zoom.is_equal_approx(original_camera_zoom),
		"world-state changes keep camera zoom unchanged",
	)
	_expect(
		is_equal_approx(hero.get_appearance_height(), original_hero_height),
		"world-state changes keep hero size unchanged",
	)
	_expect(hero.position == original_hero_position, "world-state changes keep hero position")
	_expect(hero.move_speed == original_move_speed, "world-state changes keep movement speed")
	_expect(
		tile_grid_preview.tile_size == original_tile_size,
		"world-state changes keep tile size unchanged",
	)
	_expect(
		hero_collision.shape == original_collision_shape,
		"world-state changes keep the collision shape",
	)
	_expect(
		hero_collision.transform == original_collision_transform,
		"world-state changes keep the collision transform",
	)
	_expect(
		preview.find_children("*", "CollisionObject2D", true, false).is_empty(),
		"embedded WorldStatePreview contains no collision bodies or areas",
	)

	await _close_visual_lab(tree, visual_lab)
	var reopened_visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	if reopened_visual_lab != null:
		var reopened_preview: WORLD_STATE_PREVIEW_SCRIPT = (
			reopened_visual_lab.get_node_or_null("TestWorld/WorldStatePreview")
			as WORLD_STATE_PREVIEW_SCRIPT
		)
		var reopened_status := reopened_visual_lab.get_node_or_null(
			"InterfaceLayer/Interface/Text/WorldStateStatus"
		) as Label
		_expect(reopened_preview != null, "reopened VisualLab has WorldStatePreview")
		_expect(reopened_status != null, "reopened VisualLab has world-state status")
		if reopened_preview != null and reopened_status != null:
			_expect_preview_state(reopened_preview, true, "reopened VisualLab loads restored")
			_expect(
				reopened_status.text == RESTORED_STATUS,
				"reopened VisualLab displays restored status",
			)
		await _close_visual_lab(tree, reopened_visual_lab)

	_write_legacy_or_invalid_settings(null)
	await _expect_file_world_fallback(
		tree,
		visual_lab_scene,
		"missing world_state remains backward compatible",
	)
	_write_legacy_or_invalid_settings("unknown-world")
	await _expect_file_world_fallback(
		tree,
		visual_lab_scene,
		"unknown world_state falls back to damaged",
	)


func _expect_file_world_fallback(
	tree: SceneTree,
	visual_lab_scene: PackedScene,
	description: String,
) -> void:
	var visual_lab := await _open_visual_lab(tree, visual_lab_scene)
	if visual_lab == null:
		return
	var preview: WORLD_STATE_PREVIEW_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/WorldStatePreview"
	) as WORLD_STATE_PREVIEW_SCRIPT
	var status := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/WorldStateStatus"
	) as Label
	var camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var hero: HERO_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter"
	) as HERO_SCRIPT
	var tile_grid_preview: TILE_GRID_PREVIEW_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/TileComparison/TileGridPreview"
	) as TILE_GRID_PREVIEW_SCRIPT
	_expect(preview != null, "%s: WorldStatePreview exists" % description)
	_expect(status != null, "%s: world-state status exists" % description)
	if preview != null:
		_expect_preview_state(preview, false, description)
	if status != null:
		_expect(status.text == DAMAGED_STATUS, "%s: damaged HUD text" % description)
	_expect(
		camera != null and camera.zoom == Vector2(0.75, 0.75),
		"%s: existing camera setting still loads" % description,
	)
	_expect(
		hero != null and is_equal_approx(hero.get_appearance_height(), 96.0),
		"%s: existing hero-size setting still loads" % description,
	)
	_expect(
		tile_grid_preview != null and tile_grid_preview.tile_size == 64,
		"%s: existing tile-size setting still loads" % description,
	)
	await _close_visual_lab(tree, visual_lab)


func _expect_preview_state(
	preview: WORLD_STATE_PREVIEW_SCRIPT,
	expected_restored: bool,
	description: String,
) -> void:
	var damaged_state := preview.get_node_or_null("DamagedState") as Node2D
	var restored_state := preview.get_node_or_null("RestoredState") as Node2D
	_expect(damaged_state != null, "%s: DamagedState exists" % description)
	_expect(restored_state != null, "%s: RestoredState exists" % description)
	if damaged_state == null or restored_state == null:
		return
	_expect(preview.is_restored() == expected_restored, "%s: current state" % description)
	_expect(
		damaged_state.visible == not expected_restored,
		"%s: DamagedState visibility" % description,
	)
	_expect(
		restored_state.visible == expected_restored,
		"%s: RestoredState visibility" % description,
	)
	_expect(
		damaged_state.visible != restored_state.visible,
		"%s: exactly one state is visible" % description,
	)


func _expect_input_mapping() -> void:
	_expect(InputMap.has_action(TOGGLE_ACTION), "InputMap defines world-state toggle")
	if not InputMap.has_action(TOGGLE_ACTION):
		return
	_expect(_has_key_mapping(TOGGLE_ACTION, KEY_V), "world-state toggle uses physical V")
	_expect(
		_has_button_mapping(TOGGLE_ACTION, JOY_BUTTON_A),
		"world-state toggle uses Controller-A",
	)


func _expect_saved_world_state(expected_id: String) -> void:
	var settings := ConfigFile.new()
	_expect(settings.load(SETTINGS_TEST_PATH) == OK, "saved settings file loads")
	_expect(
		settings.get_value("visual_lab", "world_state", "") == expected_id,
		"saved settings contain world_state=%s" % expected_id,
	)


func _write_legacy_or_invalid_settings(world_state: Variant) -> void:
	var settings := ConfigFile.new()
	settings.set_value("meta", "version", 1)
	settings.set_value("visual_lab", "camera_zoom", "wide")
	settings.set_value("visual_lab", "hero_size", "large")
	settings.set_value("visual_lab", "tile_size", "large")
	if world_state != null:
		settings.set_value("visual_lab", "world_state", world_state)
	_expect(settings.save(SETTINGS_TEST_PATH) == OK, "world-state fixture can be saved")


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


func _has_key_mapping(action: StringName, expected_key: Key) -> bool:
	for input_event in InputMap.action_get_events(action):
		var key_event := input_event as InputEventKey
		if key_event != null and key_event.physical_keycode == expected_key:
			return true
	return false


func _has_button_mapping(action: StringName, expected_button: JoyButton) -> bool:
	for input_event in InputMap.action_get_events(action):
		var button_event := input_event as InputEventJoypadButton
		if button_event != null and button_event.button_index == expected_button:
			return true
	return false


func _pressed_key(keycode: Key, echo: bool = false) -> InputEventKey:
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	event.pressed = true
	event.echo = echo
	return event


func _pressed_button(button_index: JoyButton) -> InputEventJoypadButton:
	var event := InputEventJoypadButton.new()
	event.button_index = button_index
	event.pressed = true
	return event


func _remember_and_set_test_path() -> void:
	_had_settings_path_override = ProjectSettings.has_setting(SETTINGS_PATH_PROJECT_KEY)
	if _had_settings_path_override:
		_original_settings_path = ProjectSettings.get_setting(SETTINGS_PATH_PROJECT_KEY)
	ProjectSettings.set_setting(SETTINGS_PATH_PROJECT_KEY, SETTINGS_TEST_PATH)
	_expect(
		ProjectSettings.get_setting(SETTINGS_PATH_PROJECT_KEY) == SETTINGS_TEST_PATH,
		"world-state tests use only the isolated settings path",
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
	_expect(remove_error == OK, "isolated world-state test settings can be removed")


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLabWorldState: %s" % description)
