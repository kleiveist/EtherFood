extends RefCounted

const HERO_SCENE_PATH := "res://scenes/gameplay/hero/hero_character.tscn"
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")
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
	_expect(hero.get_node_or_null("Visual/Shadow") is Polygon2D, "HeroCharacter has a shadow")
	_expect(hero.get_node_or_null("Visual/Body") is Polygon2D, "HeroCharacter has a body")
	_expect(hero.get_node_or_null("Visual/Head") is Polygon2D, "HeroCharacter has a head")
	var facing_marker := hero.get_node_or_null("Visual/FacingMarker") as Polygon2D
	_expect(facing_marker != null, "HeroCharacter has a facing marker")
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


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("HeroCharacter: %s" % description)
