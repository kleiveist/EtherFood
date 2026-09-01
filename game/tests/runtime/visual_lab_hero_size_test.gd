extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const SIZE_DECREASE_ACTION := &"dev_hero_size_decrease"
const SIZE_INCREASE_ACTION := &"dev_hero_size_increase"
const ZOOM_OUT_ACTION := &"dev_camera_zoom_out"
const ZOOM_IN_ACTION := &"dev_camera_zoom_in"
const REFERENCE_HEIGHT := 76.0
const SMALL_HEIGHT := 64.0
const MEDIUM_HEIGHT := 80.0
const LARGE_HEIGHT := 96.0
const SMALL_STATUS := "Figur: Klein · 64 Weltpixel"
const MEDIUM_STATUS := "Figur: Mittel · 80 Weltpixel"
const LARGE_STATUS := "Figur: Groß · 96 Weltpixel"

var failures: PackedStringArray = []


func run(tree: SceneTree) -> PackedStringArray:
	_expect_input_mappings()
	var visual_lab_scene := load(VISUAL_LAB_SCENE_PATH) as PackedScene
	_expect(visual_lab_scene != null, "VisualLab scene loads")
	if visual_lab_scene == null:
		return failures

	var visual_lab_node := visual_lab_scene.instantiate()
	_expect(visual_lab_node is Control, "VisualLab instantiates as Control")
	if not visual_lab_node is Control:
		if visual_lab_node != null:
			visual_lab_node.free()
		return failures

	var visual_lab := visual_lab_node as Control
	tree.root.add_child(visual_lab)
	await tree.process_frame

	var hero: HERO_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter"
	) as HERO_SCRIPT
	var visual := visual_lab.get_node_or_null("TestWorld/HeroCharacter/Visual") as Node2D
	var shadow := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Shadow"
	) as Polygon2D
	var appearance := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance"
	) as Node2D
	var body := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance/Body"
	) as Polygon2D
	var head := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance/Head"
	) as Polygon2D
	var facing_marker := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/FacingMarker"
	) as Polygon2D
	var hero_collision := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/CollisionShape2D"
	) as CollisionShape2D
	var player_camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var size_status := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/HeroSizeStatus"
	) as Label
	var decrease_hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/HeroSizeDecreaseHint"
	) as Label
	var increase_hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/HeroSizeIncreaseHint"
	) as Label

	_expect(hero != null, "VisualLab has HeroCharacter")
	_expect(visual != null, "HeroCharacter has Visual")
	_expect(shadow != null, "HeroCharacter has Shadow")
	_expect(appearance != null, "HeroCharacter has Appearance")
	_expect(body != null, "Appearance has Body")
	_expect(head != null, "Appearance has Head")
	_expect(facing_marker != null, "HeroCharacter has FacingMarker")
	_expect(
		hero_collision != null and hero_collision.shape != null,
		"HeroCharacter has a collision shape",
	)
	_expect(player_camera != null, "HeroCharacter has PlayerCamera")
	_expect(size_status != null, "VisualLab has a hero-size Label")
	_expect(
		decrease_hint != null
		and decrease_hint.text == "R / Controller links: kleiner",
		"VisualLab shows the size-decrease hint",
	)
	_expect(
		increase_hint != null
		and increase_hint.text == "F / Controller oben: größer",
		"VisualLab shows the size-increase hint",
	)

	if (
		hero == null
		or visual == null
		or shadow == null
		or appearance == null
		or body == null
		or head == null
		or facing_marker == null
		or hero_collision == null
		or hero_collision.shape == null
		or player_camera == null
		or size_status == null
	):
		visual_lab.queue_free()
		await tree.process_frame
		return failures

	_expect(appearance.get_parent() == visual, "Appearance is directly under Visual")
	_expect(body.get_parent() == appearance, "Body is directly under Appearance")
	_expect(head.get_parent() == appearance, "Head is directly under Appearance")
	_expect(shadow.get_parent() == visual, "Shadow stays outside Appearance")
	_expect(facing_marker.get_parent() == visual, "FacingMarker stays outside Appearance")
	_expect(hero_collision.get_parent() == hero, "collision stays outside Appearance")
	_expect(player_camera.get_parent() == hero, "camera stays outside Appearance")

	var original_hero_position := hero.position
	var original_hero_scale := hero.scale
	var original_move_speed := hero.move_speed
	var original_facing_direction := hero.facing_direction
	var original_collision_shape := hero_collision.shape
	var original_collision_transform := hero_collision.transform
	var original_shadow_transform := shadow.transform
	var original_facing_marker_transform := facing_marker.transform
	var original_camera_position := player_camera.position
	var original_camera_zoom := player_camera.zoom
	var original_foot_position := appearance.global_position

	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		SMALL_HEIGHT,
		SMALL_STATUS,
		"VisualLab starts at the small hero-size default",
	)

	visual_lab._unhandled_input(_pressed_key(KEY_F, true))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		SMALL_HEIGHT,
		SMALL_STATUS,
		"held size input does not repeat",
	)

	visual_lab._unhandled_input(_pressed_key(KEY_R))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		SMALL_HEIGHT,
		SMALL_STATUS,
		"size decrease stops at small",
	)

	visual_lab._unhandled_input(_pressed_key(KEY_F))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		MEDIUM_HEIGHT,
		MEDIUM_STATUS,
		"F changes small hero size to medium",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_F))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		LARGE_HEIGHT,
		LARGE_STATUS,
		"F changes medium hero size to large",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_F))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		LARGE_HEIGHT,
		LARGE_STATUS,
		"size increase stops at large",
	)

	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_X))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		MEDIUM_HEIGHT,
		MEDIUM_STATUS,
		"left controller action changes large size to medium",
	)
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_X))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		SMALL_HEIGHT,
		SMALL_STATUS,
		"left controller action changes medium size to small",
	)
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_Y))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		MEDIUM_HEIGHT,
		MEDIUM_STATUS,
		"top controller action changes small size to medium",
	)
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_Y))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		LARGE_HEIGHT,
		LARGE_STATUS,
		"top controller action changes medium size to large",
	)

	for _iteration in range(24):
		visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_X))
		visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_Y))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		LARGE_HEIGHT,
		LARGE_STATUS,
		"repeated switching does not accumulate scale error",
	)

	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_X))
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		MEDIUM_HEIGHT,
		MEDIUM_STATUS,
		"controller returns hero size to medium",
	)
	_expect(
		player_camera.zoom.is_equal_approx(original_camera_zoom),
		"hero-size changes keep camera zoom unchanged",
	)

	visual_lab._unhandled_input(_pressed_action(ZOOM_OUT_ACTION))
	_expect(player_camera.zoom == Vector2.ONE, "zoom can change independently")
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		MEDIUM_HEIGHT,
		MEDIUM_STATUS,
		"zoom changes keep hero size unchanged",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_F))
	_expect(player_camera.zoom == Vector2.ONE, "size can change without camera zoom")
	_expect_size_state(
		appearance,
		body,
		head,
		size_status,
		LARGE_HEIGHT,
		LARGE_STATUS,
		"hero size remains independent at medium zoom",
	)
	visual_lab._unhandled_input(_pressed_action(ZOOM_IN_ACTION))
	_expect(
		player_camera.zoom.is_equal_approx(original_camera_zoom),
		"zoom returns independently to near",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_R))

	_expect(hero.position == original_hero_position, "size keeps hero position unchanged")
	_expect(hero.scale == original_hero_scale, "size never scales HeroCharacter")
	_expect(hero.move_speed == original_move_speed, "size keeps movement speed unchanged")
	_expect(
		hero.facing_direction == original_facing_direction,
		"size keeps facing direction unchanged",
	)
	_expect(
		hero_collision.shape == original_collision_shape,
		"size keeps the collision shape unchanged",
	)
	_expect(
		hero_collision.transform == original_collision_transform,
		"size keeps the collision transform unchanged",
	)
	_expect(shadow.transform == original_shadow_transform, "size keeps shadow unchanged")
	_expect(
		facing_marker.transform == original_facing_marker_transform,
		"size keeps facing marker unchanged",
	)
	_expect(
		player_camera.position == original_camera_position,
		"size keeps camera position unchanged",
	)
	_expect(
		appearance.global_position.is_equal_approx(original_foot_position),
		"all size changes keep the foot position fixed",
	)

	visual_lab.queue_free()
	await tree.process_frame
	await _expect_reopened_medium_size(tree, visual_lab_scene)
	return failures


func _expect_reopened_medium_size(tree: SceneTree, visual_lab_scene: PackedScene) -> void:
	var reopened_node := visual_lab_scene.instantiate()
	_expect(reopened_node is Control, "VisualLab can be reopened")
	if not reopened_node is Control:
		if reopened_node != null:
			reopened_node.free()
		return
	var reopened_visual_lab := reopened_node as Control
	tree.root.add_child(reopened_visual_lab)
	await tree.process_frame
	var reopened_appearance := reopened_visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance"
	) as Node2D
	var reopened_body := reopened_visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance/Body"
	) as Polygon2D
	var reopened_head := reopened_visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance/Head"
	) as Polygon2D
	var reopened_status := reopened_visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/HeroSizeStatus"
	) as Label
	_expect(reopened_appearance != null, "reopened VisualLab has Appearance")
	_expect(reopened_body != null, "reopened VisualLab has Body")
	_expect(reopened_head != null, "reopened VisualLab has Head")
	_expect(reopened_status != null, "reopened VisualLab has hero-size status")
	if (
		reopened_appearance != null
		and reopened_body != null
		and reopened_head != null
		and reopened_status != null
	):
		_expect_size_state(
			reopened_appearance,
			reopened_body,
			reopened_head,
			reopened_status,
			MEDIUM_HEIGHT,
			MEDIUM_STATUS,
			"reopened VisualLab loads the saved medium hero size",
		)
	reopened_visual_lab.queue_free()
	await tree.process_frame


func _expect_input_mappings() -> void:
	_expect(InputMap.has_action(SIZE_DECREASE_ACTION), "InputMap defines size decrease")
	_expect(InputMap.has_action(SIZE_INCREASE_ACTION), "InputMap defines size increase")
	if InputMap.has_action(SIZE_DECREASE_ACTION):
		_expect(
			_has_key_mapping(SIZE_DECREASE_ACTION, KEY_R),
			"size decrease uses the physical R key",
		)
		_expect(
			_has_button_mapping(SIZE_DECREASE_ACTION, JOY_BUTTON_X),
			"size decrease uses the left controller action",
		)
	if InputMap.has_action(SIZE_INCREASE_ACTION):
		_expect(
			_has_key_mapping(SIZE_INCREASE_ACTION, KEY_F),
			"size increase uses the physical F key",
		)
		_expect(
			_has_button_mapping(SIZE_INCREASE_ACTION, JOY_BUTTON_Y),
			"size increase uses the top controller action",
		)


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


func _pressed_action(action: StringName) -> InputEventAction:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	return event


func _expect_size_state(
	appearance: Node2D,
	body: Polygon2D,
	head: Polygon2D,
	status: Label,
	expected_height: float,
	expected_status: String,
	description: String,
) -> void:
	var expected_scale := Vector2.ONE * (expected_height / REFERENCE_HEIGHT)
	_expect(
		appearance.scale.is_equal_approx(expected_scale),
		"%s: uniform Appearance scale" % description,
	)
	_expect(
		is_equal_approx(_measure_height(body, head), expected_height),
		"%s: measured head-to-foot height" % description,
	)
	_expect(
		is_equal_approx(_measure_bottom(body, head), appearance.global_position.y),
		"%s: visible foot stays at the scale origin" % description,
	)
	_expect(status.text == expected_status, "%s: status text" % description)


func _measure_height(body: Polygon2D, head: Polygon2D) -> float:
	return _measure_bottom(body, head) - _measure_top(body, head)


func _measure_top(body: Polygon2D, head: Polygon2D) -> float:
	var top := INF
	var polygons: Array[Polygon2D] = [body, head]
	for polygon in polygons:
		for point in polygon.polygon:
			top = minf(top, polygon.to_global(point).y)
	return top


func _measure_bottom(body: Polygon2D, head: Polygon2D) -> float:
	var bottom := -INF
	var polygons: Array[Polygon2D] = [body, head]
	for polygon in polygons:
		for point in polygon.polygon:
			bottom = maxf(bottom, polygon.to_global(point).y)
	return bottom


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLabHeroSize: %s" % description)
