extends RefCounted

const HERO_SCENE_PATH := "res://scenes/gameplay/hero/hero_character.tscn"
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
const EXPECTED_APPEARANCE_REFERENCE_HEIGHT := 76.0
const MOVEMENT_ACTIONS: Array[StringName] = [
	&"gameplay_move_left",
	&"gameplay_move_right",
	&"gameplay_move_up",
	&"gameplay_move_down",
]

var failures: PackedStringArray = []


func run(tree: SceneTree) -> PackedStringArray:
	_release_movement_actions()
	var hero_scene := load(HERO_SCENE_PATH) as PackedScene
	_expect(hero_scene != null, "HeroCharacter scene loads")
	if hero_scene == null:
		return failures

	var hero_node := hero_scene.instantiate()
	_expect(hero_node is CharacterBody2D, "HeroCharacter instantiates as CharacterBody2D")
	if not hero_node is CharacterBody2D:
		if hero_node != null:
			hero_node.free()
		return failures

	var hero: HERO_SCRIPT = hero_node as HERO_SCRIPT
	tree.root.add_child(hero)
	await tree.physics_frame

	_expect(
		hero.motion_mode == CharacterBody2D.MOTION_MODE_FLOATING,
		"HeroCharacter uses floating motion mode",
	)
	var collision_shape := hero.get_node_or_null("CollisionShape2D") as CollisionShape2D
	_expect(collision_shape != null, "HeroCharacter has a CollisionShape2D")
	if collision_shape != null:
		_expect(collision_shape.shape != null, "HeroCharacter collision has a shape")
	var player_camera := hero.get_node_or_null("PlayerCamera") as Camera2D
	_expect(player_camera != null, "HeroCharacter has a PlayerCamera")
	if player_camera != null:
		_expect(player_camera.get_parent() == hero, "PlayerCamera is a direct child")
		_expect(not player_camera.enabled, "PlayerCamera is disabled by default")
		_expect(player_camera.zoom == Vector2.ONE, "PlayerCamera uses neutral zoom")
		_expect(
			not player_camera.position_smoothing_enabled,
			"PlayerCamera has position smoothing disabled",
		)
		_expect(
			player_camera.process_callback == Camera2D.CAMERA2D_PROCESS_PHYSICS,
			"PlayerCamera updates during physics frames",
		)
	var visual := hero.get_node_or_null("Visual") as Node2D
	var shadow := hero.get_node_or_null("Visual/Shadow") as Polygon2D
	var appearance := hero.get_node_or_null("Visual/Appearance") as Node2D
	var body := hero.get_node_or_null("Visual/Appearance/Body") as Polygon2D
	var head := hero.get_node_or_null("Visual/Appearance/Head") as Polygon2D
	_expect(visual != null, "HeroCharacter has a Visual group")
	_expect(shadow != null, "HeroCharacter has a shadow")
	_expect(appearance != null, "HeroCharacter has an Appearance group")
	_expect(body != null, "HeroCharacter has a body under Appearance")
	_expect(head != null, "HeroCharacter has a head under Appearance")
	if visual != null and appearance != null:
		_expect(appearance.get_parent() == visual, "Appearance is directly under Visual")
		_expect(appearance.position == Vector2(0, 10), "Appearance origin is at the feet")
		_expect(appearance.scale == Vector2.ONE, "Appearance uses its reference scale")
	if appearance != null and body != null and head != null:
		_expect(body.get_parent() == appearance, "Body is directly under Appearance")
		_expect(head.get_parent() == appearance, "Head is directly under Appearance")
		_expect(appearance.get_child_count() == 2, "Appearance contains only body and head")
		_expect(
			is_equal_approx(
				_measure_appearance_height(body, head),
				EXPECTED_APPEARANCE_REFERENCE_HEIGHT,
			),
			"unscaled head and body are 76 world pixels high",
		)
		_expect(
			is_equal_approx(_measure_appearance_bottom(body, head), appearance.global_position.y),
			"Appearance origin matches the visible foot position",
		)
		var reference_foot_position := appearance.global_position
		hero.set_appearance_height(80.0)
		_expect(
			appearance.scale.is_equal_approx(Vector2.ONE * (80.0 / 76.0)),
			"HeroCharacter applies a uniform appearance scale from the reference height",
		)
		_expect(
			is_equal_approx(hero.get_appearance_height(), 80.0),
			"HeroCharacter reports its scaled appearance height",
		)
		_expect(
			appearance.global_position.is_equal_approx(reference_foot_position),
			"scaling Appearance keeps its foot origin fixed",
		)
		hero.set_appearance_height(EXPECTED_APPEARANCE_REFERENCE_HEIGHT)
	var facing_marker := hero.get_node_or_null("Visual/FacingMarker") as Polygon2D
	_expect(facing_marker != null, "HeroCharacter has a facing marker")
	if visual != null:
		_expect(shadow == null or shadow.get_parent() == visual, "Shadow stays outside Appearance")
		_expect(
			facing_marker == null or facing_marker.get_parent() == visual,
			"Facing marker stays outside Appearance",
		)
	_expect(hero.move_speed > 0.0, "HeroCharacter move speed is positive")
	_expect(hero.facing_direction == Vector2.DOWN, "HeroCharacter initially faces down")
	_expect(hero.velocity.is_zero_approx(), "HeroCharacter remains still without input")

	Input.action_press(&"gameplay_move_right")
	await tree.physics_frame
	_expect(hero.velocity.x > 0.0, "right input produces positive X velocity")
	_expect(is_zero_approx(hero.velocity.y), "right input has no vertical velocity")
	Input.action_release(&"gameplay_move_right")
	await tree.physics_frame
	_expect(hero.velocity.is_zero_approx(), "releasing right input stops movement")
	_expect(
		hero.facing_direction == Vector2.RIGHT,
		"facing direction remains right after releasing input",
	)
	if facing_marker != null:
		_expect(
			is_equal_approx(facing_marker.rotation, -PI / 2.0),
			"facing marker visibly remains pointed right",
		)

	Input.action_press(&"gameplay_move_left")
	await tree.physics_frame
	_expect(hero.velocity.x < 0.0, "left input produces negative X velocity")
	Input.action_release(&"gameplay_move_left")
	await tree.physics_frame

	Input.action_press(&"gameplay_move_up")
	await tree.physics_frame
	_expect(hero.velocity.y < 0.0, "up input produces negative Y velocity")
	Input.action_release(&"gameplay_move_up")
	await tree.physics_frame

	Input.action_press(&"gameplay_move_down")
	await tree.physics_frame
	_expect(hero.velocity.y > 0.0, "down input produces positive Y velocity")
	Input.action_release(&"gameplay_move_down")
	await tree.physics_frame

	Input.action_press(&"gameplay_move_right", 0.5)
	await tree.physics_frame
	_expect(hero.velocity.x > 0.0, "analog-strength input produces movement")
	_expect(
		hero.velocity.length() < hero.move_speed,
		"analog-strength input preserves partial movement speed",
	)
	Input.action_release(&"gameplay_move_right")
	await tree.physics_frame

	Input.action_press(&"gameplay_move_right")
	Input.action_press(&"gameplay_move_down")
	await tree.physics_frame
	_expect(
		hero.velocity.x > 0.0 and hero.velocity.y > 0.0,
		"diagonal input produces diagonal velocity",
	)
	_expect(
		hero.velocity.length() <= hero.move_speed + 0.001,
		"diagonal velocity does not exceed move speed",
	)
	Input.action_release(&"gameplay_move_right")
	Input.action_release(&"gameplay_move_down")
	await tree.physics_frame
	_expect(hero.velocity.is_zero_approx(), "releasing all actions clears velocity")
	_expect(
		hero.facing_direction == Vector2.DOWN,
		"four-direction facing remains after diagonal input is released",
	)
	if facing_marker != null:
		_expect(
			is_zero_approx(facing_marker.rotation),
			"facing marker visibly remains pointed down",
		)

	_release_movement_actions()
	hero.queue_free()
	await tree.process_frame
	return failures


func _release_movement_actions() -> void:
	for action in MOVEMENT_ACTIONS:
		Input.action_release(action)


func _measure_appearance_height(body: Polygon2D, head: Polygon2D) -> float:
	return _measure_appearance_bottom(body, head) - _measure_appearance_top(body, head)


func _measure_appearance_top(body: Polygon2D, head: Polygon2D) -> float:
	var top := INF
	var polygons: Array[Polygon2D] = [body, head]
	for polygon in polygons:
		for point in polygon.polygon:
			top = minf(top, polygon.to_global(point).y)
	return top


func _measure_appearance_bottom(body: Polygon2D, head: Polygon2D) -> float:
	var bottom := -INF
	var polygons: Array[Polygon2D] = [body, head]
	for polygon in polygons:
		for point in polygon.polygon:
			bottom = maxf(bottom, polygon.to_global(point).y)
	return bottom


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("HeroCharacter: %s" % description)
