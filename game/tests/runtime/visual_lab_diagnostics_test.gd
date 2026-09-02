extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const COLLISION_OVERLAY_SCRIPT := preload(
	"res://scenes/dev/collision_debug_overlay.gd"
)
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const SETTINGS_PATH_PROJECT_KEY := "etherfood/development/visual_lab_settings_path"
const SETTINGS_TEST_PATH := "user://visual_lab_diagnostics_test.cfg"
const DIAGNOSTICS_ACTION := &"dev_diagnostics_toggle"
const COLLISION_ACTION := &"dev_collision_debug_toggle"

var failures: PackedStringArray = []
var _had_settings_path_override := false
var _original_settings_path: Variant = null


func run(tree: SceneTree) -> PackedStringArray:
	_remember_and_set_test_path()
	_remove_test_settings()
	_expect_input_mapping()

	var packed_scene := load(VISUAL_LAB_SCENE_PATH) as PackedScene
	_expect(packed_scene != null, "VisualLab scene loads")
	if packed_scene == null:
		_cleanup_test_path()
		return failures
	var visual_lab := await _open_visual_lab(tree, packed_scene)
	if visual_lab != null:
		await _expect_diagnostics_contract(tree, visual_lab)
		await _close_visual_lab(tree, visual_lab)

	var reopened_visual_lab := await _open_visual_lab(tree, packed_scene)
	if reopened_visual_lab != null:
		var panel := reopened_visual_lab.get_node_or_null(
			"InterfaceLayer/DiagnosticsPanel"
		) as Panel
		var overlay: COLLISION_OVERLAY_SCRIPT = reopened_visual_lab.get_node_or_null(
			"TestWorld/CollisionDebugOverlay"
		) as COLLISION_OVERLAY_SCRIPT
		var hero: HERO_SCRIPT = reopened_visual_lab.get_node_or_null(
			"TestWorld/HeroCharacter"
		) as HERO_SCRIPT
		_expect(panel != null and not panel.visible, "reopened diagnostics start hidden")
		_expect(overlay != null and not overlay.visible, "reopened collision debug starts hidden")
		_expect(
			hero != null and is_equal_approx(hero.get_appearance_height(), 96.0),
			"existing hero preset remains stored while diagnostics do not",
		)
		await _close_visual_lab(tree, reopened_visual_lab)

	_cleanup_test_path()
	return failures


func _expect_diagnostics_contract(tree: SceneTree, visual_lab: Control) -> void:
	var panel := visual_lab.get_node_or_null("InterfaceLayer/DiagnosticsPanel") as Panel
	var title := visual_lab.get_node_or_null(
		"InterfaceLayer/DiagnosticsPanel/Title"
	) as Label
	var values := visual_lab.get_node_or_null(
		"InterfaceLayer/DiagnosticsPanel/Values"
	) as Label
	var overlay: COLLISION_OVERLAY_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/CollisionDebugOverlay"
	) as COLLISION_OVERLAY_SCRIPT
	var hero: HERO_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter"
	) as HERO_SCRIPT
	var hero_collision := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/CollisionShape2D"
	) as CollisionShape2D
	var obstacle_collision := visual_lab.get_node_or_null(
		"TestWorld/TestObstacle/CollisionShape2D"
	) as CollisionShape2D

	_expect(panel != null, "InterfaceLayer has DiagnosticsPanel")
	_expect(title != null and title.get_parent() == panel, "DiagnosticsPanel has direct Title")
	_expect(values != null and values.get_parent() == panel, "DiagnosticsPanel has direct Values")
	_expect(title != null and title.text == "DIAGNOSE", "diagnostics title is exact")
	_expect(overlay != null, "TestWorld has CollisionDebugOverlay")
	_expect(hero != null, "VisualLab retains CharacterBody2D hero")
	_expect(hero_collision != null, "hero retains CollisionShape2D")
	_expect(obstacle_collision != null, "obstacle retains CollisionShape2D")
	if panel == null or values == null or overlay == null or hero == null:
		return

	_expect(not panel.visible, "diagnostics start hidden")
	_expect(not overlay.visible, "collision debug starts hidden")
	_expect(
		overlay.find_children("*", "CollisionShape2D", true, false).is_empty(),
		"debug overlay creates no physics shapes",
	)
	var panel_style := panel.get_theme_stylebox("panel") as StyleBoxFlat
	_expect(panel_style != null, "diagnostics use a pixel panel")
	if panel_style != null:
		_expect(panel_style.border_width_left > 0, "diagnostics panel has a clear border")
		_expect(panel_style.corner_radius_top_left == 0, "diagnostics panel has square corners")

	visual_lab._unhandled_input(_pressed_action(DIAGNOSTICS_ACTION))
	_expect(panel.visible, "F3 action shows diagnostics")
	_expect_diagnostic_values(visual_lab, values, hero)
	var values_before_update := values.text
	await tree.create_timer(0.21).timeout
	_expect(not values.text.is_empty(), "diagnostics continue updating after 0.2 seconds")
	_expect(
		_values_have_numeric_fps(values.text),
		"FPS remains numeric after periodic update",
	)
	_expect(not values_before_update.is_empty(), "initial values are populated immediately")

	visual_lab._unhandled_input(_pressed_key(KEY_F3, true))
	_expect(panel.visible, "held F3 does not toggle diagnostics repeatedly")
	visual_lab._unhandled_input(_pressed_key(KEY_F3))
	_expect(not panel.visible, "second F3 press hides diagnostics")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_BACK))
	_expect(panel.visible, "Controller-Select shows diagnostics")

	visual_lab._unhandled_input(_pressed_action(&"dev_camera_zoom_out"))
	visual_lab._unhandled_input(_pressed_action(&"dev_hero_size_increase"))
	visual_lab._unhandled_input(_pressed_action(&"dev_tile_size_increase"))
	visual_lab._unhandled_input(_pressed_action(&"dev_world_state_toggle"))
	visual_lab._unhandled_input(_pressed_action(&"dev_pixel_snap_toggle"))
	visual_lab._unhandled_input(_pressed_action(&"dev_texture_filter_toggle"))
	_expect(values.text.contains("Kamera: 1,00×"), "diagnostics show active camera zoom")
	_expect(values.text.contains("Figur: 96 px"), "diagnostics show active hero size")
	_expect(values.text.contains("Tiles: 48 × 48 px"), "diagnostics show active tile size")
	_expect(values.text.contains("Welt: Wiederhergestellt"), "diagnostics show active world state")
	_expect(values.text.contains("Pixel-Snap: AN"), "diagnostics show active pixel snap")
	_expect(values.text.contains("Texturfilter: Weich"), "diagnostics show active filter")

	var player_line_before := _line_with_prefix(values.text, "Spieler: ")
	Input.action_press(&"gameplay_move_right")
	await tree.physics_frame
	await tree.physics_frame
	Input.action_release(&"gameplay_move_right")
	visual_lab._update_diagnostics_values()
	var player_line_after := _line_with_prefix(values.text, "Spieler: ")
	_expect(
		player_line_after != player_line_before,
		"displayed player coordinates change after movement",
	)

	var original_hero_shape := hero_collision.shape if hero_collision != null else null
	var original_obstacle_shape := (
		obstacle_collision.shape if obstacle_collision != null else null
	)
	visual_lab._unhandled_input(_pressed_action(COLLISION_ACTION))
	_expect(overlay.visible, "F4 action shows collision debug independently")
	_expect(panel.visible, "collision toggle leaves diagnostics visible")
	visual_lab._unhandled_input(_pressed_key(KEY_F4, true))
	_expect(overlay.visible, "held F4 does not toggle collision debug repeatedly")
	_expect_collision_geometry(overlay, hero_collision, obstacle_collision)

	var hero_rect_before := overlay.get_hero_collision_rect()
	var hero_position_before := hero.position
	Input.action_press(&"gameplay_move_down")
	await tree.physics_frame
	await tree.physics_frame
	Input.action_release(&"gameplay_move_down")
	var hero_delta := hero.position - hero_position_before
	var hero_rect_after := overlay.get_hero_collision_rect()
	_expect(
		hero_rect_after.position.is_equal_approx(hero_rect_before.position + hero_delta),
		"hero collision drawing follows the moving hero",
	)
	_expect(
		hero_collision == null or hero_collision.shape == original_hero_shape,
		"collision debug does not change the hero physics shape",
	)
	_expect(
		obstacle_collision == null or obstacle_collision.shape == original_obstacle_shape,
		"collision debug does not change the obstacle physics shape",
	)

	visual_lab._unhandled_input(_pressed_key(KEY_F4))
	_expect(not overlay.visible, "second F4 press hides collision debug")
	_expect(panel.visible, "F4 remains independent from F3 diagnostics")
	_expect_diagnostics_not_saved()


func _expect_diagnostic_values(
	visual_lab: Control,
	values: Label,
	hero: HERO_SCRIPT,
) -> void:
	var window_size := visual_lab.get_window().size
	var player_camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var test_world := visual_lab.get_node_or_null("TestWorld") as Node2D
	_expect(_values_have_numeric_fps(values.text), "FPS is displayed as a number")
	_expect(
		values.text.contains("Spieler: %s" % _format_position(hero.global_position)),
		"diagnostics show current player coordinates",
	)
	_expect(player_camera != null, "diagnostics retain the player camera")
	if player_camera != null:
		_expect(
			values.text.contains(
				"Kamera-Pos: %s" % _format_position(
					player_camera.get_screen_center_position()
				)
			),
			"diagnostics show the actual camera center separately",
		)
	_expect(test_world != null, "diagnostics retain the test world")
	if test_world != null:
		_expect(
			values.text.contains(
				"Weltanker: %s" % _format_position(test_world.global_position)
			),
			"diagnostics show the world anchor separately",
		)
	_expect(values.text.contains("Kamera: 1,50×"), "diagnostics show initial camera zoom")
	_expect(values.text.contains("Figur: 80 px"), "diagnostics show initial hero size")
	_expect(values.text.contains("Tiles: 32 × 32 px"), "diagnostics show initial tile size")
	_expect(values.text.contains("Welt: Beschädigt"), "diagnostics show initial world state")
	_expect(values.text.contains("Pixel-Snap: AUS"), "diagnostics show initial pixel snap")
	_expect(
		values.text.contains("Texturfilter: Nearest-Neighbor"),
		"diagnostics show the initial texture filter",
	)
	_expect(
		values.text.contains("Fenster: %d × %d" % [window_size.x, window_size.y]),
		"diagnostics show the actual window size",
	)


func _expect_collision_geometry(
	overlay: COLLISION_OVERLAY_SCRIPT,
	hero_collision: CollisionShape2D,
	obstacle_collision: CollisionShape2D,
) -> void:
	var hero_rect := overlay.get_hero_collision_rect()
	var obstacle_rect := overlay.get_obstacle_collision_rect()
	_expect(hero_rect.size.is_equal_approx(Vector2(28, 16)), "hero debug uses 28 by 16 feet")
	_expect(
		hero_collision != null
		and hero_rect.get_center().is_equal_approx(
			overlay.to_local(hero_collision.global_position)
		),
		"hero debug matches the real foot collision position",
	)
	_expect(
		obstacle_rect.size.is_equal_approx(Vector2(150, 80)),
		"obstacle debug matches the real 150 by 80 shape",
	)
	_expect(
		obstacle_collision != null
		and obstacle_rect.get_center().is_equal_approx(
			overlay.to_local(obstacle_collision.global_position)
		),
		"obstacle debug matches the real obstacle position",
	)
	var world_boundaries := overlay.get_world_boundary_rects()
	_expect(world_boundaries.size() == 4, "collision debug draws all four world boundaries")
	var vertical_count := 0
	var horizontal_count := 0
	for boundary in world_boundaries:
		if boundary.size.is_equal_approx(Vector2(32, 2160)):
			vertical_count += 1
		elif boundary.size.is_equal_approx(Vector2(3840, 32)):
			horizontal_count += 1
	_expect(vertical_count == 2, "collision debug draws both vertical world limits")
	_expect(horizontal_count == 2, "collision debug draws both horizontal world limits")


func _expect_diagnostics_not_saved() -> void:
	var settings := ConfigFile.new()
	_expect(settings.load(SETTINGS_TEST_PATH) == OK, "existing test values are saved")
	_expect(
		settings.get_value("visual_lab", "hero_size", "") == "large",
		"existing hero value remains saved",
	)
	_expect(
		settings.get_value("visual_lab", "camera_zoom", "") == "medium",
		"existing camera value remains saved",
	)
	_expect(
		settings.get_value("visual_lab", "pixel_snap", false) == true,
		"active pixel-snap test value remains saved",
	)
	_expect(
		settings.get_value("visual_lab", "texture_filter", "") == "soft",
		"active texture-filter test value remains saved",
	)
	_expect(
		not settings.has_section_key("visual_lab", "diagnostics_visible"),
		"diagnostics visibility is not saved",
	)
	_expect(
		not settings.has_section_key("visual_lab", "collision_debug_visible"),
		"collision visibility is not saved",
	)


func _expect_input_mapping() -> void:
	_expect(InputMap.has_action(DIAGNOSTICS_ACTION), "InputMap defines diagnostics toggle")
	_expect(InputMap.has_action(COLLISION_ACTION), "InputMap defines collision toggle")
	_expect(_has_key_mapping(DIAGNOSTICS_ACTION, KEY_F3), "diagnostics toggle uses F3")
	_expect(
		_has_button_mapping(DIAGNOSTICS_ACTION, JOY_BUTTON_BACK),
		"diagnostics toggle uses Controller-Select/Back",
	)
	_expect(_has_key_mapping(COLLISION_ACTION, KEY_F4), "collision toggle uses F4")


func _values_have_numeric_fps(text: String) -> bool:
	var fps_line := _line_with_prefix(text, "FPS: ")
	if fps_line.is_empty():
		return false
	return fps_line.trim_prefix("FPS: ").is_valid_int()


func _line_with_prefix(text: String, prefix: String) -> String:
	for line in text.split("\n"):
		if line.begins_with(prefix):
			return line
	return ""


func _format_position(position: Vector2) -> String:
	return "x=%s · y=%s" % [
		("%.2f" % position.x).replace(".", ","),
		("%.2f" % position.y).replace(".", ","),
	]


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


func _has_button_mapping(action: StringName, expected_button: JoyButton) -> bool:
	for input_event in InputMap.action_get_events(action):
		var button_event := input_event as InputEventJoypadButton
		if button_event != null and button_event.button_index == expected_button:
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
	_expect(remove_error == OK, "isolated diagnostics settings can be removed")


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLab diagnostics: %s" % description)
