extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const SIZE_DECREASE_ACTION := &"dev_hero_size_decrease"
const SIZE_INCREASE_ACTION := &"dev_hero_size_increase"
const BASELINE_WORLD_Y := 1760.0
const WORLD_BOUNDS := Rect2(0, 0, 3840, 2160)
const SCALE_REFERENCE_HINT := "Referenzobjekte: vorläufige Testmaße"
const REFERENCE_SPECS := [
	{
		"node_name": "SmallEnemyReference",
		"label": "Kleiner Gegner · 56 px",
		"height": 56.0,
	},
	{
		"node_name": "DoorReference",
		"label": "Tür · 112 px",
		"height": 112.0,
	},
	{
		"node_name": "HouseWallReference",
		"label": "Hauswand · 144 px",
		"height": 144.0,
	},
	{
		"node_name": "LargeEnemyReference",
		"label": "Großer Gegner · 128 px",
		"height": 128.0,
	},
	{
		"node_name": "TreeReference",
		"label": "Baum · 192 px",
		"height": 192.0,
	},
]

var failures: PackedStringArray = []


func run(tree: SceneTree) -> PackedStringArray:
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

	var test_world := visual_lab.get_node_or_null("TestWorld") as Node2D
	var scale_comparison := visual_lab.get_node_or_null(
		"TestWorld/ScaleComparison"
	) as Node2D
	var baseline := visual_lab.get_node_or_null(
		"TestWorld/ScaleComparison/Baseline"
	) as Line2D
	var hero_marker := visual_lab.get_node_or_null(
		"TestWorld/ScaleComparison/HeroStandMarker"
	) as Polygon2D
	var hero_marker_label := visual_lab.get_node_or_null(
		"TestWorld/ScaleComparison/HeroStandMarker/Label"
	) as Label
	var scale_reference_hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/ScaleReferenceHint"
	) as Label

	_expect(test_world != null, "VisualLab has TestWorld")
	_expect(scale_comparison != null, "TestWorld has ScaleComparison")
	_expect(baseline != null, "ScaleComparison has a Baseline")
	_expect(hero_marker != null, "ScaleComparison has a HeroStandMarker")
	_expect(hero_marker_label != null, "HeroStandMarker has a Label")
	_expect(scale_reference_hint != null, "VisualLab has a scale-reference HUD hint")
	if scale_reference_hint != null:
		_expect(
			scale_reference_hint.text == SCALE_REFERENCE_HINT,
			"HUD identifies reference dimensions as provisional",
		)

	if scale_comparison == null:
		visual_lab.queue_free()
		await tree.process_frame
		return failures

	_expect(
		scale_comparison.get_parent() == test_world,
		"ScaleComparison is directly under TestWorld",
	)
	_expect(
		scale_comparison.global_position.y == BASELINE_WORLD_Y,
		"ScaleComparison uses the proportional lower-world baseline",
	)
	_expect(
		BASELINE_WORLD_Y > WORLD_BOUNDS.get_center().y,
		"ScaleComparison lies in the lower half of the enlarged world",
	)

	if baseline != null:
		_expect(baseline.get_parent() == scale_comparison, "Baseline is directly grouped")
		_expect(baseline.visible and baseline.width > 0.0, "Baseline is clearly visible")
		_expect(baseline.points.size() >= 2, "Baseline spans the comparison area")
		for point in baseline.points:
			_expect(
				is_equal_approx(baseline.to_global(point).y, BASELINE_WORLD_Y),
				"every Baseline point uses the shared world Y coordinate",
			)

	if hero_marker != null:
		_expect(
			is_equal_approx(hero_marker.global_position.y, BASELINE_WORLD_Y),
			"HeroStandMarker sits on the shared baseline",
		)
		_expect(hero_marker.visible, "HeroStandMarker is visible")
	if hero_marker_label != null:
		_expect(
			hero_marker_label.get_parent() == hero_marker,
			"HeroStandMarker Label is a direct child",
		)
		_expect(hero_marker_label.text == "Held · steuerbar", "HeroStandMarker is labeled")

	var previous_reference_x := -INF
	for reference_spec in REFERENCE_SPECS:
		var reference_name := str(reference_spec["node_name"])
		var reference := scale_comparison.get_node_or_null(reference_name) as Node2D
		_expect(reference != null, "ScaleComparison has %s" % reference_name)
		if reference == null:
			continue
		_expect(
			reference.get_parent() == scale_comparison,
			"%s is directly grouped" % reference_name,
		)
		_expect(
			is_equal_approx(reference.global_position.y, BASELINE_WORLD_Y),
			"%s origin sits on the shared baseline" % reference_name,
		)
		_expect(
			reference.position.x > previous_reference_x,
			"%s follows the left-to-right comparison order" % reference_name,
		)
		previous_reference_x = reference.position.x

		var shape := reference.get_node_or_null("Shape") as Polygon2D
		var label := reference.get_node_or_null("Label") as Label
		_expect(shape != null, "%s has a Shape" % reference_name)
		_expect(label != null, "%s has a Label" % reference_name)
		if shape != null:
			_expect(shape.get_parent() == reference, "%s Shape is a direct child" % reference_name)
			_expect(shape.visible, "%s Shape is visible" % reference_name)
			var vertical_bounds := _polygon_world_vertical_bounds(shape)
			var expected_height := float(reference_spec["height"])
			_expect(
				is_equal_approx(vertical_bounds.y - vertical_bounds.x, expected_height),
				"%s Shape has the intended height" % reference_name,
			)
			_expect(
				is_equal_approx(vertical_bounds.y, BASELINE_WORLD_Y),
				"%s Shape grows upward from the shared baseline" % reference_name,
			)
			for point in shape.polygon:
				_expect(
					WORLD_BOUNDS.has_point(shape.to_global(point)),
					"%s Shape stays inside TestWorld" % reference_name,
				)
		if label != null:
			_expect(label.get_parent() == reference, "%s Label is a direct child" % reference_name)
			_expect(
				label.text == str(reference_spec["label"]),
				"%s Label states its provisional height" % reference_name,
			)

	_expect_reference_order(scale_comparison, hero_marker)
	_expect(
		scale_comparison.find_children("*", "CollisionObject2D", true, false).is_empty(),
		"reference objects contain no collision bodies or areas",
	)
	_expect(
		scale_comparison.find_children("*", "CollisionShape2D", true, false).is_empty(),
		"reference objects contain no collision shapes",
	)
	_expect(
		scale_comparison.find_children("*", "CollisionPolygon2D", true, false).is_empty(),
		"reference objects contain no collision polygons",
	)

	_expect_hero_sizes_still_work(visual_lab)
	visual_lab.queue_free()
	await tree.process_frame
	return failures


func _expect_reference_order(scale_comparison: Node2D, hero_marker: Polygon2D) -> void:
	if hero_marker == null:
		return
	var ordered_names := [
		"SmallEnemyReference",
		"HeroStandMarker",
		"DoorReference",
		"HouseWallReference",
		"LargeEnemyReference",
		"TreeReference",
	]
	var previous_x := -INF
	for node_name in ordered_names:
		var comparison_node := scale_comparison.get_node_or_null(node_name) as Node2D
		if comparison_node == null:
			return
		_expect(
			comparison_node.position.x > previous_x,
			"%s appears in the documented comparison order" % node_name,
		)
		previous_x = comparison_node.position.x


func _expect_hero_sizes_still_work(visual_lab: Control) -> void:
	var body := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance/Body"
	) as Polygon2D
	var head := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/Visual/Appearance/Head"
	) as Polygon2D
	_expect(body != null and head != null, "VisualLab retains the scalable hero appearance")
	if body == null or head == null:
		return
	_expect(
		is_equal_approx(_hero_appearance_height(body, head), 80.0),
		"hero still starts at 80 world pixels",
	)
	visual_lab._unhandled_input(_pressed_action(SIZE_DECREASE_ACTION))
	_expect(
		is_equal_approx(_hero_appearance_height(body, head), 64.0),
		"hero still reaches 64 world pixels",
	)
	visual_lab._unhandled_input(_pressed_action(SIZE_INCREASE_ACTION))
	visual_lab._unhandled_input(_pressed_action(SIZE_INCREASE_ACTION))
	_expect(
		is_equal_approx(_hero_appearance_height(body, head), 96.0),
		"hero still reaches 96 world pixels",
	)


func _polygon_world_vertical_bounds(shape: Polygon2D) -> Vector2:
	var top := INF
	var bottom := -INF
	for point in shape.polygon:
		var world_y := shape.to_global(point).y
		top = minf(top, world_y)
		bottom = maxf(bottom, world_y)
	return Vector2(top, bottom)


func _hero_appearance_height(body: Polygon2D, head: Polygon2D) -> float:
	var top := INF
	var bottom := -INF
	var polygons: Array[Polygon2D] = [body, head]
	for polygon in polygons:
		for point in polygon.polygon:
			var world_y := polygon.to_global(point).y
			top = minf(top, world_y)
			bottom = maxf(bottom, world_y)
	return bottom - top


func _pressed_action(action: StringName) -> InputEventAction:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	return event


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLabScaleReference: %s" % description)
