extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const TILE_GRID_PREVIEW_SCRIPT := preload("res://scenes/dev/tile_grid_preview.gd")
const SIZE_DECREASE_ACTION := &"dev_tile_size_decrease"
const SIZE_INCREASE_ACTION := &"dev_tile_size_increase"
const ZOOM_IN_ACTION := &"dev_camera_zoom_in"
const HERO_SIZE_INCREASE_ACTION := &"dev_hero_size_increase"
const PREVIEW_SIZE := Vector2(768.0, 384.0)
const SMALL_TILE_SIZE := 32
const MEDIUM_TILE_SIZE := 48
const LARGE_TILE_SIZE := 64
const SMALL_STATUS := "Tiles: Klein · 32 × 32 Weltpixel"
const MEDIUM_STATUS := "Tiles: Mittel · 48 × 48 Weltpixel"
const LARGE_STATUS := "Tiles: Groß · 64 × 64 Weltpixel"

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

	var tile_comparison := visual_lab.get_node_or_null(
		"TestWorld/TileComparison"
	) as Node2D
	var tile_grid_preview: TILE_GRID_PREVIEW_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/TileComparison/TileGridPreview"
	) as TILE_GRID_PREVIEW_SCRIPT
	var title := visual_lab.get_node_or_null(
		"TestWorld/TileComparison/Title"
	) as Label
	var tile_size_status := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/TileSizeStatus"
	) as Label
	var decrease_hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/TileSizeDecreaseHint"
	) as Label
	var increase_hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/TileSizeIncreaseHint"
	) as Label
	var player_camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var hero: HERO_SCRIPT = visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter"
	) as HERO_SCRIPT
	var hero_collision := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/CollisionShape2D"
	) as CollisionShape2D
	var floor := visual_lab.get_node_or_null("TestWorld/Floor") as Polygon2D

	_expect(tile_comparison != null, "TestWorld has TileComparison")
	_expect(tile_grid_preview != null, "TileComparison has TileGridPreview")
	_expect(title != null, "TileComparison has a Title")
	_expect(tile_size_status != null, "VisualLab has a tile-size status Label")
	_expect(player_camera != null, "VisualLab retains PlayerCamera")
	_expect(hero != null, "VisualLab retains HeroCharacter")
	_expect(
		hero_collision != null and hero_collision.shape != null,
		"VisualLab retains the hero collision shape",
	)
	_expect(floor != null, "VisualLab retains its Floor")
	_expect(
		decrease_hint != null
		and decrease_hint.text == "T / linker Stick-Klick: kleiner",
		"VisualLab shows the tile-size-decrease hint",
	)
	_expect(
		increase_hint != null
		and increase_hint.text == "G / rechter Stick-Klick: größer",
		"VisualLab shows the tile-size-increase hint",
	)

	if (
		tile_comparison == null
		or tile_grid_preview == null
		or tile_size_status == null
		or player_camera == null
		or hero == null
		or hero_collision == null
		or hero_collision.shape == null
	):
		visual_lab.queue_free()
		await tree.process_frame
		return failures

	_expect(
		tile_comparison.position == Vector2(1536, 220),
		"TileComparison uses the reviewed world position",
	)
	_expect(
		tile_grid_preview.get_parent() == tile_comparison,
		"TileGridPreview is directly under TileComparison",
	)
	_expect(tile_grid_preview.visible, "TileGridPreview is visible")
	_expect(
		TILE_GRID_PREVIEW_SCRIPT.PREVIEW_SIZE == PREVIEW_SIZE,
		"TileGridPreview has a fixed 768 by 384 world-pixel area",
	)
	if title != null:
		_expect(title.get_parent() == tile_comparison, "Title is directly grouped")
		_expect(
			title.text == "Tilegrößenvergleich · feste Fläche 768 × 384",
			"Title identifies the fixed comparison area",
		)

	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		MEDIUM_TILE_SIZE,
		16,
		8,
		MEDIUM_STATUS,
		"VisualLab starts at medium tile size",
	)

	var original_camera_zoom := player_camera.zoom
	var original_camera_limits := Rect2(
		player_camera.limit_left,
		player_camera.limit_top,
		player_camera.limit_right - player_camera.limit_left,
		player_camera.limit_bottom - player_camera.limit_top,
	)
	var original_hero_height := hero.get_appearance_height()
	var original_hero_position := hero.position
	var original_hero_scale := hero.scale
	var original_move_speed := hero.move_speed
	var original_collision_shape := hero_collision.shape
	var original_collision_transform := hero_collision.transform

	visual_lab._unhandled_input(_pressed_key(KEY_G, true))
	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		MEDIUM_TILE_SIZE,
		16,
		8,
		MEDIUM_STATUS,
		"held tile-size input does not repeat",
	)

	visual_lab._unhandled_input(_pressed_key(KEY_T))
	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		SMALL_TILE_SIZE,
		24,
		12,
		SMALL_STATUS,
		"T changes medium tiles to small",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_T))
	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		SMALL_TILE_SIZE,
		24,
		12,
		SMALL_STATUS,
		"tile-size decrease stops at small",
	)

	visual_lab._unhandled_input(_pressed_key(KEY_G))
	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		MEDIUM_TILE_SIZE,
		16,
		8,
		MEDIUM_STATUS,
		"G changes small tiles to medium",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_G))
	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		LARGE_TILE_SIZE,
		12,
		6,
		LARGE_STATUS,
		"G changes medium tiles to large",
	)
	visual_lab._unhandled_input(_pressed_key(KEY_G))
	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		LARGE_TILE_SIZE,
		12,
		6,
		LARGE_STATUS,
		"tile-size increase stops at large",
	)

	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_LEFT_STICK))
	_expect(tile_grid_preview.tile_size == MEDIUM_TILE_SIZE, "left stick click decreases")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_LEFT_STICK))
	_expect(tile_grid_preview.tile_size == SMALL_TILE_SIZE, "left stick reaches small")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_LEFT_STICK))
	_expect(tile_grid_preview.tile_size == SMALL_TILE_SIZE, "left stick stops at small")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_RIGHT_STICK))
	_expect(tile_grid_preview.tile_size == MEDIUM_TILE_SIZE, "right stick reaches medium")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_RIGHT_STICK))
	_expect(tile_grid_preview.tile_size == LARGE_TILE_SIZE, "right stick reaches large")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_RIGHT_STICK))
	_expect(tile_grid_preview.tile_size == LARGE_TILE_SIZE, "right stick stops at large")
	visual_lab._unhandled_input(_pressed_button(JOY_BUTTON_LEFT_STICK))
	_expect_tile_state(
		tile_grid_preview,
		tile_size_status,
		MEDIUM_TILE_SIZE,
		16,
		8,
		MEDIUM_STATUS,
		"controller returns tiles to medium",
	)

	_expect(
		player_camera.zoom.is_equal_approx(original_camera_zoom),
		"tile-size changes keep camera zoom unchanged",
	)
	_expect(
		is_equal_approx(hero.get_appearance_height(), original_hero_height),
		"tile-size changes keep hero height unchanged",
	)
	_expect(hero.position == original_hero_position, "tile-size changes keep hero position")
	_expect(hero.scale == original_hero_scale, "tile-size changes never scale HeroCharacter")
	_expect(hero.move_speed == original_move_speed, "tile-size changes keep movement speed")
	_expect(
		hero_collision.shape == original_collision_shape,
		"tile-size changes keep the collision shape",
	)
	_expect(
		hero_collision.transform == original_collision_transform,
		"tile-size changes keep the collision transform",
	)
	_expect(
		_camera_limits(player_camera) == original_camera_limits,
		"tile-size changes keep all camera limits",
	)
	_expect(
		tile_comparison.find_children("*", "CollisionObject2D", true, false).is_empty(),
		"TileComparison contains no collision bodies or areas",
	)
	_expect(
		tile_comparison.find_children("*", "CollisionShape2D", true, false).is_empty(),
		"TileComparison contains no collision shapes",
	)
	_expect(
		tile_comparison.find_children("*", "CollisionPolygon2D", true, false).is_empty(),
		"TileComparison contains no collision polygons",
	)
	if floor != null:
		_expect(
			_polygon_bounds(floor.polygon) == Rect2(0, 0, 3840, 2160),
			"tile-size presets keep the enlarged TestWorld unchanged",
		)

	visual_lab._unhandled_input(_pressed_action(ZOOM_IN_ACTION))
	_expect(player_camera.zoom == Vector2(1.5, 1.5), "camera zoom changes independently")
	_expect(tile_grid_preview.tile_size == MEDIUM_TILE_SIZE, "zoom keeps tile size unchanged")
	visual_lab._unhandled_input(_pressed_action(HERO_SIZE_INCREASE_ACTION))
	_expect(
		is_equal_approx(hero.get_appearance_height(), 96.0),
		"hero size changes independently",
	)
	_expect(tile_grid_preview.tile_size == MEDIUM_TILE_SIZE, "hero size keeps tiles unchanged")
	visual_lab._unhandled_input(_pressed_key(KEY_T))
	_expect(tile_grid_preview.tile_size == SMALL_TILE_SIZE, "tiles still change independently")
	_expect(player_camera.zoom == Vector2(1.5, 1.5), "tiles retain the selected camera zoom")
	_expect(
		is_equal_approx(hero.get_appearance_height(), 96.0),
		"tiles retain the selected hero size",
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
	var reopened_preview: TILE_GRID_PREVIEW_SCRIPT = reopened_visual_lab.get_node_or_null(
		"TestWorld/TileComparison/TileGridPreview"
	) as TILE_GRID_PREVIEW_SCRIPT
	var reopened_status := reopened_visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/TileSizeStatus"
	) as Label
	_expect(reopened_preview != null, "reopened VisualLab has TileGridPreview")
	_expect(reopened_status != null, "reopened VisualLab has tile-size status")
	if reopened_preview != null and reopened_status != null:
		_expect_tile_state(
			reopened_preview,
			reopened_status,
			MEDIUM_TILE_SIZE,
			16,
			8,
			MEDIUM_STATUS,
			"reopened VisualLab resets to medium tile size",
		)
	reopened_visual_lab.queue_free()
	await tree.process_frame


func _expect_input_mappings() -> void:
	_expect(InputMap.has_action(SIZE_DECREASE_ACTION), "InputMap defines tile decrease")
	_expect(InputMap.has_action(SIZE_INCREASE_ACTION), "InputMap defines tile increase")
	if InputMap.has_action(SIZE_DECREASE_ACTION):
		_expect(
			_has_key_mapping(SIZE_DECREASE_ACTION, KEY_T),
			"tile decrease uses the physical T key",
		)
		_expect(
			_has_button_mapping(SIZE_DECREASE_ACTION, JOY_BUTTON_LEFT_STICK),
			"tile decrease uses the left stick click",
		)
	if InputMap.has_action(SIZE_INCREASE_ACTION):
		_expect(
			_has_key_mapping(SIZE_INCREASE_ACTION, KEY_G),
			"tile increase uses the physical G key",
		)
		_expect(
			_has_button_mapping(SIZE_INCREASE_ACTION, JOY_BUTTON_RIGHT_STICK),
			"tile increase uses the right stick click",
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


func _expect_tile_state(
	preview: TILE_GRID_PREVIEW_SCRIPT,
	status: Label,
	expected_tile_size: int,
	expected_columns: int,
	expected_rows: int,
	expected_status: String,
	description: String,
) -> void:
	_expect(preview.tile_size == expected_tile_size, "%s: selected tile size" % description)
	_expect(
		preview.get_column_count() == expected_columns,
		"%s: expected column count" % description,
	)
	_expect(
		preview.get_row_count() == expected_rows,
		"%s: expected row count" % description,
	)
	_expect(
		preview.get_column_count() * preview.tile_size == int(PREVIEW_SIZE.x),
		"%s: columns retain the fixed preview width" % description,
	)
	_expect(
		preview.get_row_count() * preview.tile_size == int(PREVIEW_SIZE.y),
		"%s: rows retain the fixed preview height" % description,
	)
	_expect(status.text == expected_status, "%s: status text" % description)


func _camera_limits(camera: Camera2D) -> Rect2:
	return Rect2(
		camera.limit_left,
		camera.limit_top,
		camera.limit_right - camera.limit_left,
		camera.limit_bottom - camera.limit_top,
	)


func _polygon_bounds(points: PackedVector2Array) -> Rect2:
	if points.is_empty():
		return Rect2()
	var minimum := points[0]
	var maximum := points[0]
	for point in points:
		minimum.x = minf(minimum.x, point.x)
		minimum.y = minf(minimum.y, point.y)
		maximum.x = maxf(maximum.x, point.x)
		maximum.y = maxf(maximum.y, point.y)
	return Rect2(minimum, maximum - minimum)


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLabTileSize: %s" % description)
