extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const SETTINGS_PATH_PROJECT_KEY := "etherfood/development/visual_lab_settings_path"
const SETTINGS_TEST_PATH := "user://visual_lab_pixel_snap_test.cfg"
const PIXEL_SNAP_ACTION := &"dev_pixel_snap_toggle"
const CONTROLS_ACTION := &"dev_controls_toggle"
const DIAGNOSTICS_ACTION := &"dev_diagnostics_toggle"

var failures: PackedStringArray = []
var _had_settings_path_override := false
var _original_settings_path: Variant = null


func run(tree: SceneTree) -> PackedStringArray:
	_remember_and_set_test_path()
	_remove_test_settings()
	_expect_input_mapping()
	var initial_viewport_snap := tree.root.snap_2d_transforms_to_pixel
	var initial_vertex_snap := tree.root.snap_2d_vertices_to_pixel

	var packed_scene := load(VISUAL_LAB_SCENE_PATH) as PackedScene
	_expect(packed_scene != null, "VisualLab scene loads")
	if packed_scene == null:
		_cleanup_test_path()
		return failures

	var visual_lab := await _open_visual_lab(tree, packed_scene)
	if visual_lab == null:
		_cleanup_test_path()
		return failures
	await _expect_pixel_snap_contract(tree, visual_lab)
	await _close_visual_lab(tree, visual_lab)
	_expect(
		tree.root.snap_2d_transforms_to_pixel == initial_viewport_snap,
		"closing VisualLab restores the previous viewport setting",
	)
	_expect(
		tree.root.snap_2d_vertices_to_pixel == initial_vertex_snap,
		"closing VisualLab restores the previous vertex-snap setting",
	)

	var reopened_visual_lab := await _open_visual_lab(tree, packed_scene)
	if reopened_visual_lab != null:
		_expect_pixel_snap_state(
			reopened_visual_lab,
			true,
			"reopened VisualLab restores saved pixel snap",
		)
		await _close_visual_lab(tree, reopened_visual_lab)
	_expect(
		tree.root.snap_2d_transforms_to_pixel == initial_viewport_snap,
		"reopened VisualLab restores the previous viewport setting on exit",
	)
	_expect(
		tree.root.snap_2d_vertices_to_pixel == initial_vertex_snap,
		"reopened VisualLab restores the previous vertex-snap setting on exit",
	)

	_write_settings_fixture(null, false)
	var legacy_visual_lab := await _open_visual_lab(tree, packed_scene)
	if legacy_visual_lab != null:
		_expect_pixel_snap_state(
			legacy_visual_lab,
			false,
			"version 1 preset without pixel snap uses the safe default",
		)
		await _close_visual_lab(tree, legacy_visual_lab)

	_write_settings_fixture("invalid", true)
	var invalid_visual_lab := await _open_visual_lab(tree, packed_scene)
	if invalid_visual_lab != null:
		_expect_pixel_snap_state(
			invalid_visual_lab,
			false,
			"invalid pixel-snap value uses the safe default",
		)
		await _close_visual_lab(tree, invalid_visual_lab)

	_cleanup_test_path()
	return failures


func _expect_pixel_snap_contract(tree: SceneTree, visual_lab: Control) -> void:
	var hero: HERO_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter"
	) as HERO_SCRIPT
	var camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var hero_visual := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual"
	) as Node2D
	var test_world := visual_lab.get_node_or_null("TestWorld") as Node2D
	var hero_collision := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/CollisionShape2D"
	) as CollisionShape2D
	var obstacle_collision := visual_lab.get_node_or_null(
		"TestWorld/TestObstacle/CollisionShape2D"
	) as CollisionShape2D
	var controls := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface"
	) as MarginContainer
	var button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/RenderingButtons/PixelSnapButton"
	) as Button
	var hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/RenderingHints/PixelSnapToggleHint"
	) as Label
	var diagnostics := visual_lab.get_node_or_null(
		"InterfaceLayer/DiagnosticsPanel/Values"
	) as Label

	_expect(hero != null, "VisualLab retains the moving hero")
	_expect(camera != null, "VisualLab retains the following camera")
	_expect(hero_visual != null, "VisualLab retains a separate hero visual")
	_expect(test_world != null, "VisualLab retains the test world")
	_expect(hero_collision != null, "VisualLab retains the hero collision")
	_expect(obstacle_collision != null, "VisualLab retains the obstacle collision")
	_expect(controls != null, "VisualLab retains the controls menu")
	_expect(button != null, "controls menu has a pixel-snap button")
	_expect(
		button != null and button.toggle_mode,
		"pixel-snap menu button exposes an on/off state",
	)
	_expect(
		hint != null and hint.text == "X / Klick / Auswahl: AN / AUS",
		"controls menu explains all pixel-snap inputs",
	)
	_expect(diagnostics != null, "VisualLab retains diagnostics values")
	if (
		hero == null
		or camera == null
		or hero_visual == null
		or test_world == null
		or hero_collision == null
		or obstacle_collision == null
		or controls == null
		or button == null
		or diagnostics == null
	):
		return

	var original_move_speed := hero.move_speed
	var original_zoom := camera.zoom
	var original_camera_position := camera.position
	var original_visual_position := hero_visual.position
	var original_camera_top_level := camera.top_level
	var original_visual_top_level := hero_visual.top_level
	var original_world_transform := test_world.global_transform
	var original_hero_shape := hero_collision.shape
	var original_obstacle_shape := obstacle_collision.shape

	_expect_pixel_snap_state(visual_lab, false, "VisualLab starts with pixel snap off")
	visual_lab._unhandled_input(_pressed_action(CONTROLS_ACTION))
	_expect(controls.visible, "F5 opens the menu containing the pixel-snap control")
	_expect(button.is_visible_in_tree(), "pixel-snap button is visible in the open menu")
	_expect(button.has_focus(), "opening the menu focuses the pixel-snap button")
	visual_lab._unhandled_input(_pressed_action(DIAGNOSTICS_ACTION))
	_expect(
		diagnostics.text.contains("Pixel-Snap: AUS"),
		"diagnostics immediately show pixel snap off",
	)
	await _expect_motion_contract(
		tree,
		visual_lab,
		hero,
		camera,
		false,
		"pixel snap off",
	)

	hero.position = Vector2(1840.25, 1020.5)
	var fractional_position := hero.position
	visual_lab._unhandled_input(_pressed_key(KEY_X, true))
	_expect_pixel_snap_state(
		visual_lab,
		false,
		"held pixel-snap shortcut does not toggle repeatedly",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_X))
	_expect_pixel_snap_state(visual_lab, true, "X enables pixel snap while running")
	_expect(
		hero.position.is_equal_approx(fractional_position),
		"enabling pixel snap does not round the logical hero position",
	)
	_expect(
		_is_on_grid(
			hero_visual.global_position
			- visual_lab._pixel_snap_world_phase_bias() * 2.0,
			visual_lab._pixel_snap_world_grid_step(),
		),
		"enabling pixel snap aligns only the rendered hero to the output grid",
	)
	_expect(
		_is_on_grid(
			camera.global_position - visual_lab._pixel_snap_world_phase_bias(),
			visual_lab._pixel_snap_world_grid_step(),
		),
		"enabling pixel snap aligns the camera target to the same output grid",
	)
	_expect(
		camera.top_level == original_camera_top_level
		and hero_visual.top_level == original_visual_top_level,
		"pixel snap keeps camera and hero visual in their shared world hierarchy",
	)
	_expect(
		diagnostics.text.contains("Pixel-Snap: AN"),
		"diagnostics immediately show pixel snap on",
	)
	_expect(
		diagnostics.text.contains("Viewport-Transform-Snap: AUS"),
		"diagnostics expose the intentionally disabled per-item transform snap",
	)
	_expect(
		diagnostics.text.contains("Rasterphase: 0,25 Ausgabepixel"),
		"diagnostics expose the stable output-pixel phase",
	)
	_expect_saved_pixel_snap(true)

	button.button_pressed = false
	button.pressed.emit()
	_expect_pixel_snap_state(visual_lab, false, "menu button disables pixel snap")
	_expect(
		camera.position.is_equal_approx(original_camera_position),
		"disabling pixel snap restores the unsnapped camera anchor",
	)
	_expect(
		hero_visual.position.is_equal_approx(original_visual_position),
		"disabling pixel snap restores the unsnapped hero visual anchor",
	)
	_expect(
		camera.top_level == original_camera_top_level
		and hero_visual.top_level == original_visual_top_level,
		"disabling pixel snap restores both original transform hierarchies",
	)
	_expect_saved_pixel_snap(false)
	button.button_pressed = true
	button.pressed.emit()
	_expect_pixel_snap_state(visual_lab, true, "menu button enables pixel snap")
	_expect_saved_pixel_snap(true)
	await _expect_motion_contract(
		tree,
		visual_lab,
		hero,
		camera,
		true,
		"pixel snap on",
	)
	_expect_output_grid_matrix(visual_lab)

	_expect(hero.move_speed == original_move_speed, "pixel snap keeps hero move speed")
	_expect(camera.zoom == original_zoom, "pixel snap keeps camera zoom")
	_expect(
		test_world.global_transform.is_equal_approx(original_world_transform),
		"pixel snap keeps the world transform",
	)
	_expect(hero_collision.shape == original_hero_shape, "pixel snap keeps hero collision")
	_expect(
		obstacle_collision.shape == original_obstacle_shape,
		"pixel snap keeps obstacle collision",
	)


func _expect_motion_contract(
	tree: SceneTree,
	visual_lab: Control,
	hero: HERO_SCRIPT,
	camera: Camera2D,
	expected_pixel_snap: bool,
	description: String,
) -> void:
	hero.position = Vector2(1800.25, 1000.5)
	await tree.physics_frame
	visual_lab._update_pixel_snap_render_alignment()
	camera.force_update_scroll()
	var hero_start := hero.global_position
	var camera_start := camera.global_position

	var movement_frame_count := 4
	if expected_pixel_snap:
		var grid_step: Vector2 = visual_lab._pixel_snap_world_grid_step()
		var movement_per_frame := hero.move_speed / Engine.physics_ticks_per_second
		movement_frame_count = maxi(
			movement_frame_count,
			ceili(grid_step.x / movement_per_frame) + 2,
		)
	await _hold_action_for_physics_frames(
		tree,
		&"gameplay_move_right",
		movement_frame_count,
	)
	await tree.process_frame
	visual_lab._update_pixel_snap_render_alignment()
	var hero_movement := hero.global_position - hero_start
	var camera_movement := camera.global_position - camera_start
	_expect(hero_movement.x > 0.0, "%s: hero movement still works" % description)
	if expected_pixel_snap:
		var grid_step: Vector2 = visual_lab._pixel_snap_world_grid_step()
		var stretch_scale := hero.get_viewport().get_stretch_transform().get_scale()
		var output_camera_movement := camera_movement * camera.zoom * Vector2(
			absf(stretch_scale.x),
			absf(stretch_scale.y),
		)
		_expect(
			camera_movement.x > 0.0,
			"%s: aligned camera still follows the hero" % description,
		)
		_expect(
			absf(output_camera_movement.x - roundf(output_camera_movement.x))
			< 0.001,
			"%s: camera movement stays on whole output pixels" % description,
		)
		_expect(
			absf(camera.global_position.x - hero.global_position.x)
			<= grid_step.x / 2.0 + 0.01,
			"%s: aligned camera remains within half a grid step" % description,
		)
		var hero_visual := hero.get_node_or_null("Visual") as Node2D
		_expect(
			hero_visual != null
			and (
				hero_visual.global_position - camera.global_position
			).distance_to(visual_lab._pixel_snap_world_phase_bias())
			< 0.001,
			"%s: hero visual keeps a stable output-pixel phase" % description,
		)
	else:
		_expect(
			camera_movement.is_equal_approx(hero_movement),
			"%s: camera still follows the hero" % description,
		)
	_expect(camera.enabled and camera.is_current(), "%s: camera remains active" % description)
	_expect(
		not hero.get_viewport().snap_2d_transforms_to_pixel,
		"%s: viewport avoids independently rounding world items" % description,
	)

	hero.position = Vector2(2268.25, 1080.5)
	await _hold_action_for_physics_frames(tree, &"gameplay_move_right", 4)
	_expect(hero.position.x <= 2271.5, "%s: obstacle collision still works" % description)
	_expect(camera.limit_left == 0, "%s: left camera limit remains" % description)
	_expect(camera.limit_top == 0, "%s: top camera limit remains" % description)
	_expect(camera.limit_right == 3840, "%s: right camera limit remains" % description)
	_expect(camera.limit_bottom == 2160, "%s: bottom camera limit remains" % description)


func _expect_pixel_snap_state(
	visual_lab: Control,
	expected_enabled: bool,
	description: String,
) -> void:
	var button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/RenderingButtons/PixelSnapButton"
	) as Button
	_expect(button != null, "%s: menu button exists" % description)
	var expected_text := "Pixel-Snap: AN" if expected_enabled else "Pixel-Snap: AUS"
	_expect(
		button != null and button.text == expected_text,
		"%s: menu state text is exact" % description,
	)
	_expect(
		button != null and button.button_pressed == expected_enabled,
		"%s: menu toggle state" % description,
	)
	_expect(
		not visual_lab.get_viewport().snap_2d_transforms_to_pixel,
		"%s: global transform snap remains disabled" % description,
	)
	_expect(
		not visual_lab.get_viewport().snap_2d_vertices_to_pixel,
		"%s: vertex snap remains disabled" % description,
	)


func _expect_output_grid_matrix(visual_lab: Control) -> void:
	for output_scale in [1.0, 1.5, 2.0 / 3.0, 0.75]:
		var world_step: float = visual_lab._world_grid_step_for_output_scale(
			output_scale
		)
		_expect(
			is_equal_approx(world_step * output_scale, 1.0),
			"output scale %.3f advances by exactly one output pixel"
			% output_scale,
		)


func _is_on_grid(position: Vector2, grid_step: Vector2) -> bool:
	var snapped_position := Vector2(
		snappedf(position.x, grid_step.x),
		snappedf(position.y, grid_step.y),
	)
	return position.is_equal_approx(snapped_position)


func _expect_saved_pixel_snap(expected_enabled: bool) -> void:
	var settings := ConfigFile.new()
	_expect(settings.load(SETTINGS_TEST_PATH) == OK, "pixel-snap preset file loads")
	_expect(
		settings.get_value("visual_lab", "pixel_snap", null) == expected_enabled,
		"pixel-snap preset stores a boolean",
	)


func _expect_input_mapping() -> void:
	_expect(InputMap.has_action(PIXEL_SNAP_ACTION), "InputMap defines pixel snap toggle")
	_expect(_has_key_mapping(PIXEL_SNAP_ACTION, KEY_X), "pixel snap toggle uses X")
	_expect(
		not _has_key_mapping(&"app_pause", KEY_X),
		"pixel snap toggle does not reuse the pause key",
	)


func _hold_action_for_physics_frames(
	tree: SceneTree,
	action: StringName,
	frame_count: int,
) -> void:
	Input.action_press(action)
	for _frame in range(frame_count):
		await tree.physics_frame
	Input.action_release(action)


func _open_visual_lab(tree: SceneTree, packed_scene: PackedScene) -> Control:
	var node := packed_scene.instantiate()
	_expect(node is Control, "VisualLab instantiates as Control")
	if not node is Control:
		if node != null:
			node.free()
		return null
	var visual_lab := node as Control
	tree.root.add_child(visual_lab)
	await tree.process_frame
	return visual_lab


func _close_visual_lab(tree: SceneTree, visual_lab: Control) -> void:
	visual_lab.queue_free()
	await tree.process_frame


func _has_key_mapping(action: StringName, expected_key: Key) -> bool:
	for input_event in InputMap.action_get_events(action):
		var key_event := input_event as InputEventKey
		if key_event != null and (
			key_event.keycode == expected_key or key_event.physical_keycode == expected_key
		):
			return true
	return false


func _pressed_action(action: StringName) -> InputEventAction:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	return event


func _pressed_key(keycode: Key, echo: bool = false) -> InputEventKey:
	var event := InputEventKey.new()
	event.keycode = keycode
	event.physical_keycode = keycode
	event.pressed = true
	event.echo = echo
	return event


func _remember_and_set_test_path() -> void:
	_had_settings_path_override = ProjectSettings.has_setting(SETTINGS_PATH_PROJECT_KEY)
	if _had_settings_path_override:
		_original_settings_path = ProjectSettings.get_setting(SETTINGS_PATH_PROJECT_KEY)
	ProjectSettings.set_setting(SETTINGS_PATH_PROJECT_KEY, SETTINGS_TEST_PATH)


func _write_settings_fixture(pixel_snap_value: Variant, include_pixel_snap: bool) -> void:
	var settings := ConfigFile.new()
	settings.set_value("meta", "version", 1)
	settings.set_value("visual_lab", "camera_zoom", "near")
	settings.set_value("visual_lab", "hero_size", "medium")
	settings.set_value("visual_lab", "tile_size", "small")
	settings.set_value("visual_lab", "world_state", "damaged")
	if include_pixel_snap:
		settings.set_value("visual_lab", "pixel_snap", pixel_snap_value)
	_expect(settings.save(SETTINGS_TEST_PATH) == OK, "pixel-snap fixture can be written")


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
	_expect(remove_error == OK, "isolated pixel-snap settings can be removed")


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLabPixelSnap: %s" % description)
