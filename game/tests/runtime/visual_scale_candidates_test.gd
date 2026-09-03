extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const HERO_ROOM_SCENE_PATH := "res://scenes/gameplay/hero_room.tscn"
const SETTINGS_PATH_PROJECT_KEY := "etherfood/development/visual_lab_settings_path"
const SETTINGS_TEST_PATH := "user://visual_scale_candidates_test.cfg"
const VisualScaleProfileResource := preload(
	"res://shared/resources/visual_scale_profile.gd"
)
const CameraProfileResource := preload("res://shared/resources/camera_profile.gd")
const PROFILE_PATHS: Array[String] = [
	"res://shared/resources/visual_scale_candidate_a.tres",
	"res://shared/resources/visual_baseline_v0.tres",
	"res://shared/resources/visual_scale_candidate_c.tres",
]
const EXPECTED_PROFILES: Array[Dictionary] = [
	{
		"id": "candidate_a",
		"name": "Kandidat A · Weite Übersicht",
		"hero_height": 64.0,
		"tile_size": 32,
		"camera_zoom": 0.75,
	},
	{
		"id": "visual_scale_v0",
		"name": "Maßstab V0",
		"hero_height": 80.0,
		"tile_size": 32,
		"camera_zoom": 1.0,
	},
	{
		"id": "candidate_c",
		"name": "Kandidat C · Nah und groß",
		"hero_height": 96.0,
		"tile_size": 48,
		"camera_zoom": 1.5,
	},
]
const ALL_HERO_HEIGHTS: Array[float] = [64.0, 80.0, 96.0]
const ALL_TILE_SIZES: Array[int] = [32, 48, 64]
const ALL_CAMERA_ZOOMS: Array[float] = [0.75, 1.0, 1.5]
const REFERENCE_RESOLUTION := Vector2i(1920, 1080)

var failures: PackedStringArray = []
var _had_settings_path_override := false
var _original_settings_path: Variant = null


func run(tree: SceneTree) -> PackedStringArray:
	_remember_and_set_test_path()
	_remove_test_settings()
	_expect_profile_resources()
	await _expect_visual_lab_candidates(tree)
	await _expect_hero_room_compatibility(tree)
	_cleanup_test_path()
	return failures


func _expect_profile_resources() -> void:
	var seen_ids: Array[String] = []
	for profile_index in range(PROFILE_PATHS.size()):
		var profile := load(PROFILE_PATHS[profile_index]) as VisualScaleProfileResource
		var expected := EXPECTED_PROFILES[profile_index]
		_expect(profile != null, "scale profile %d resource loads" % profile_index)
		if profile == null:
			continue
		_expect(profile.profile_id == expected["id"], "scale profile ID is exact")
		_expect(profile.profile_name == expected["name"], "scale profile name is exact")
		_expect(not profile.comparison_focus.is_empty(), "scale profile explains its focus")
		_expect(
			is_equal_approx(profile.hero_height, float(expected["hero_height"])),
			"scale profile hero height uses an existing value",
		)
		_expect(profile.tile_size == expected["tile_size"], "scale profile tile size is exact")
		_expect(
			is_equal_approx(profile.camera_zoom, float(expected["camera_zoom"])),
			"scale profile camera zoom uses an existing value",
		)
		_expect(
			profile.hero_height in ALL_HERO_HEIGHTS,
			"scale profile introduces no hero-size variant",
		)
		_expect(profile.tile_size in ALL_TILE_SIZES, "scale profile introduces no tile variant")
		_expect(
			profile.camera_zoom in ALL_CAMERA_ZOOMS,
			"scale profile introduces no camera variant",
		)
		_expect(
			profile.reference_resolution == REFERENCE_RESOLUTION,
			"scale profile contains the configured reference resolution",
		)
		_expect(profile.aspect_ratio == "16:9", "scale profile contains the reference ratio")
		_expect(profile.pixel_snap_enabled, "scale profile uses the tested pixel snap")
		_expect(
			profile.texture_filter_id == "nearest",
			"scale profile uses the selected nearest-neighbor filter",
		)
		_expect(profile.profile_id not in seen_ids, "scale profile ID is unique")
		seen_ids.append(profile.profile_id)


func _expect_visual_lab_candidates(tree: SceneTree) -> void:
	var packed_scene := load(VISUAL_LAB_SCENE_PATH) as PackedScene
	_expect(packed_scene != null, "VisualLab scene loads")
	if packed_scene == null:
		return
	var visual_lab := await _open_scene(tree, packed_scene)
	if visual_lab == null:
		return

	var hero := visual_lab.get_node_or_null("TestWorld/HeroCharacter") as CharacterBody2D
	var camera := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var tile_preview := visual_lab.get_node_or_null(
		"TestWorld/TileComparison/TileGridPreview"
	) as Node2D
	var world_preview := visual_lab.get_node_or_null(
		"TestWorld/WorldStatePreview"
	) as Node2D
	var obstacle := visual_lab.get_node_or_null("TestWorld/TestObstacle") as StaticBody2D
	var hero_collision := visual_lab.get_node_or_null(
		"TestWorld/HeroCharacter/CollisionShape2D"
	) as CollisionShape2D
	var profile_button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/ScaleProfileButton"
	) as Button
	var pixel_snap_button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/RenderingButtons/PixelSnapButton"
	) as Button
	var texture_filter_button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/RenderingButtons/TextureFilterButton"
	) as Button
	var diagnostics := visual_lab.get_node_or_null(
		"InterfaceLayer/DiagnosticsPanel/Values"
	) as Label
	_expect(hero != null, "VisualLab candidate comparison retains the hero")
	_expect(camera != null, "VisualLab candidate comparison retains the camera")
	_expect(tile_preview != null, "VisualLab candidate comparison retains the tile grid")
	_expect(world_preview != null, "VisualLab candidate comparison retains world states")
	_expect(obstacle != null, "VisualLab candidate comparison retains its obstacle")
	_expect(hero_collision != null, "VisualLab candidate comparison retains hero collision")
	_expect(profile_button != null, "VisualLab exposes the scale-profile button")
	_expect(pixel_snap_button != null, "VisualLab retains the pixel-snap button")
	_expect(texture_filter_button != null, "VisualLab retains the filter button")
	_expect(diagnostics != null, "VisualLab retains diagnostics")
	if (
		hero == null
		or camera == null
		or tile_preview == null
		or world_preview == null
		or obstacle == null
		or hero_collision == null
		or profile_button == null
		or pixel_snap_button == null
		or texture_filter_button == null
		or diagnostics == null
	):
		await _close_scene(tree, visual_lab)
		return

	_expect(visual_lab.get_scale_profile_count() == 3, "VisualLab exposes three profiles")
	_expect(
		visual_lab._active_scale_profile_name() == "Maßstab V0",
		"fresh settings activate the selected scale baseline",
	)
	_expect(
		profile_button.text == "Maßstabsprofil: Maßstab V0",
		"profile button identifies the selected scale baseline",
	)
	var original_collision_shape := hero_collision.shape
	var original_collision_transform := hero_collision.transform
	var original_movement_config: Resource = hero.get("movement_config") as Resource

	for profile_index in range(EXPECTED_PROFILES.size()):
		var expected := EXPECTED_PROFILES[profile_index]
		var profile: VisualScaleProfileResource = visual_lab.get_scale_profile(
			profile_index
		)
		_expect(profile != null, "VisualLab returns profile %d" % profile_index)
		_expect(
			visual_lab.apply_scale_profile(profile_index) == OK,
			"scale profile %d applies as one bundle" % profile_index,
		)
		_expect(
			visual_lab._active_scale_profile_name() == expected["name"],
			"scale profile %d is recognized after applying" % profile_index,
		)
		_expect(
			profile_button.text == "Maßstabsprofil: %s" % expected["name"],
			"scale profile %d button text is exact" % profile_index,
		)
		_expect(
			is_equal_approx(float(hero.call(&"get_appearance_height")), profile.hero_height),
			"scale profile %d applies hero height" % profile_index,
		)
		_expect(
			int(tile_preview.get("tile_size")) == profile.tile_size,
			"scale profile %d applies tile size" % profile_index,
		)
		_expect(
			camera.zoom.is_equal_approx(Vector2.ONE * profile.camera_zoom),
			"scale profile %d applies camera zoom" % profile_index,
		)
		_expect(pixel_snap_button.text == "Pixel-Snap: AN", "candidate enables pixel snap")
		_expect(
			texture_filter_button.text == "Texturfilter: Nearest-Neighbor",
			"candidate applies nearest-neighbor",
		)
		_expect(
			not tree.root.snap_2d_transforms_to_pixel
			and not tree.root.snap_2d_vertices_to_pixel,
			"candidate keeps per-item viewport snapping disabled",
		)
		_expect(
			hero_collision.shape == original_collision_shape
			and hero_collision.transform == original_collision_transform,
			"scale profile %d leaves hero collision unchanged" % profile_index,
		)
		_expect(
			hero.get("movement_config") == original_movement_config,
			"scale profile %d leaves movement configuration unchanged" % profile_index,
		)
		visual_lab._update_diagnostics_values()
		_expect_candidate_diagnostics(diagnostics.text, profile)
		_expect_saved_candidate(profile)
		await _expect_candidate_motion_and_collision(
			tree,
			visual_lab,
			hero,
			camera,
			obstacle,
			profile_index,
		)

	profile_button.pressed.emit()
	_expect(
		visual_lab._active_scale_profile_name() == EXPECTED_PROFILES[0]["name"],
		"scale-profile button wraps from C to A",
	)
	visual_lab._change_hero_size(1)
	_expect(
		visual_lab._active_scale_profile_name() == "Freier Vergleich",
		"changing one bundled value returns to free comparison",
	)

	_expect(visual_lab.apply_scale_profile(1) == OK, "scale baseline applies before reopen")
	await _close_scene(tree, visual_lab)
	var reopened := await _open_scene(tree, packed_scene)
	if reopened != null:
		_expect(
			reopened._active_scale_profile_name() == EXPECTED_PROFILES[1]["name"],
			"saved individual values restore Maßstab V0 on reopen",
		)
		await _expect_full_combination_matrix(reopened)
		await _close_scene(tree, reopened)


func _expect_candidate_diagnostics(
	diagnostic_text: String,
	profile: VisualScaleProfileResource,
) -> void:
	_expect(
		diagnostic_text.contains("Maßstabsprofil: %s" % profile.profile_name),
		"diagnostics identify the active candidate",
	)
	_expect(
		diagnostic_text.contains("Figur: %d px" % roundi(profile.hero_height)),
		"diagnostics show candidate hero height",
	)
	_expect(
		diagnostic_text.contains(
			"Tiles: %d × %d px" % [profile.tile_size, profile.tile_size]
		),
		"diagnostics show candidate tile size",
	)
	_expect(
		diagnostic_text.contains("Kamera-Basis: %s×" % _format_zoom(profile.camera_zoom)),
		"diagnostics show candidate camera zoom",
	)
	_expect(
		diagnostic_text.contains("Referenzauflösung: 1920 × 1080"),
		"diagnostics show reference resolution",
	)
	_expect(
		diagnostic_text.contains("Seitenverhältnis: 16:9"),
		"diagnostics show reference ratio",
	)
	_expect(diagnostic_text.contains("Pixel-Snap: AN"), "diagnostics show pixel snap")
	_expect(
		diagnostic_text.contains("Texturfilter: Nearest-Neighbor"),
		"diagnostics show nearest-neighbor",
	)


func _expect_saved_candidate(profile: VisualScaleProfileResource) -> void:
	var settings := ConfigFile.new()
	_expect(settings.load(SETTINGS_TEST_PATH) == OK, "candidate settings file loads")
	if settings.load(SETTINGS_TEST_PATH) != OK:
		return
	_expect(
		settings.get_value("visual_lab", "hero_size", "")
		== _hero_size_id(profile.hero_height),
		"candidate stores hero size",
	)
	_expect(
		settings.get_value("visual_lab", "tile_size", "") == _tile_size_id(profile.tile_size),
		"candidate stores tile size",
	)
	_expect(
		settings.get_value("visual_lab", "camera_zoom", "")
		== _camera_zoom_id(profile.camera_zoom),
		"candidate stores camera zoom",
	)
	_expect(
		settings.get_value("visual_lab", "pixel_snap", false),
		"candidate stores pixel snap",
	)
	_expect(
		settings.get_value("visual_lab", "texture_filter", "") == "nearest",
		"candidate stores texture filter",
	)


func _expect_candidate_motion_and_collision(
	tree: SceneTree,
	visual_lab: Control,
	hero: CharacterBody2D,
	camera: Camera2D,
	obstacle: StaticBody2D,
	profile_index: int,
) -> void:
	for world_state in range(2):
		visual_lab._selected_world_state = world_state
		visual_lab._apply_world_state()
		hero.global_position = Vector2(1840, 980)
		await tree.physics_frame
		camera.force_update_scroll()
		var hero_start := hero.global_position
		var camera_start := camera.get_screen_center_position()
		Input.action_press(&"gameplay_move_right")
		await tree.physics_frame
		await tree.physics_frame
		Input.action_release(&"gameplay_move_right")
		camera.force_update_scroll()
		_expect(
			hero.global_position.x > hero_start.x,
			"profile %d moves in world state %d" % [profile_index, world_state],
		)
		_expect(
			camera.get_screen_center_position().x >= camera_start.x,
			"profile %d camera follows in world state %d"
			% [profile_index, world_state],
		)
		var start_x := obstacle.global_position.x - 160.0
		hero.global_position = Vector2(start_x, obstacle.global_position.y)
		Input.action_press(&"gameplay_move_right")
		for _frame in range(30):
			await tree.physics_frame
		Input.action_release(&"gameplay_move_right")
		_expect(
			hero.global_position.x > start_x
			and hero.global_position.x <= obstacle.global_position.x - 88.5,
			"profile %d collision works in world state %d"
			% [profile_index, world_state],
		)


func _expect_full_combination_matrix(visual_lab: Control) -> void:
	var hero := visual_lab.get_node("TestWorld/HeroCharacter") as CharacterBody2D
	var camera := visual_lab.get_node(
		"TestWorld/HeroCharacter/PlayerCamera"
	) as Camera2D
	var tile_preview := visual_lab.get_node(
		"TestWorld/TileComparison/TileGridPreview"
	) as Node2D
	var checked_combinations := 0
	for world_state in range(2):
		visual_lab._selected_world_state = world_state
		visual_lab._apply_world_state()
		for hero_index in range(ALL_HERO_HEIGHTS.size()):
			visual_lab._selected_hero_size = hero_index
			visual_lab._apply_hero_size()
			for tile_index in range(ALL_TILE_SIZES.size()):
				visual_lab._selected_tile_size = tile_index
				visual_lab._apply_tile_size()
				for zoom_index in range(ALL_CAMERA_ZOOMS.size()):
					visual_lab._selected_camera_zoom = zoom_index
					visual_lab._apply_camera_zoom()
					_expect(
						is_equal_approx(
							float(hero.call(&"get_appearance_height")),
							ALL_HERO_HEIGHTS[hero_index],
						),
						"matrix applies hero height",
					)
					_expect(
						int(tile_preview.get("tile_size")) == ALL_TILE_SIZES[tile_index],
						"matrix applies tile size",
					)
					_expect(
						camera.zoom.is_equal_approx(
							Vector2.ONE * ALL_CAMERA_ZOOMS[zoom_index]
						),
						"matrix applies camera zoom",
					)
					checked_combinations += 1
	_expect(checked_combinations == 54, "matrix covers all 54 state and scale combinations")


func _expect_hero_room_compatibility(tree: SceneTree) -> void:
	var packed_scene := load(HERO_ROOM_SCENE_PATH) as PackedScene
	_expect(packed_scene != null, "HeroRoom scene loads for scale comparison")
	if packed_scene == null:
		return
	var hero_room := await _open_scene(tree, packed_scene)
	if hero_room == null:
		return
	var hero := hero_room.get_node_or_null("World/HeroCharacter") as CharacterBody2D
	var camera := hero_room.get_node_or_null(
		"World/HeroCharacter/PlayerCamera"
	) as Camera2D
	var collision := hero_room.get_node_or_null(
		"World/HeroCharacter/CollisionShape2D"
	) as CollisionShape2D
	_expect(hero != null, "HeroRoom retains its hero")
	_expect(camera != null, "HeroRoom retains its camera")
	_expect(collision != null, "HeroRoom retains hero collision")
	if hero == null or camera == null or collision == null:
		await _close_scene(tree, hero_room)
		return
	var room_constants: Dictionary = hero_room.get_script().get_script_constant_map()
	var baseline := load(PROFILE_PATHS[1]) as VisualScaleProfileResource
	_expect(baseline != null, "HeroRoom comparison loads Maßstab V0")
	_expect(
		room_constants.get("TILE_SIZE", Vector2i.ZERO) == Vector2i(32, 32),
		"HeroRoom reports the selected 32-pixel raster",
	)
	if baseline != null:
		_expect(
			is_equal_approx(
				float(hero.call(&"get_appearance_height")),
				baseline.hero_height,
			),
			"HeroRoom reads its hero height from Maßstab V0",
		)
		_expect(
			room_constants.get("TILE_SIZE", Vector2i.ZERO)
			== Vector2i.ONE * baseline.tile_size,
			"HeroRoom raster matches Maßstab V0",
		)
		_expect(
			is_equal_approx(float(camera.call(&"get_base_zoom")), 1.5)
			and is_equal_approx(baseline.camera_zoom, 1.0),
			"small-room 1.50 camera remains an explicit scene override",
		)
	var original_shape := collision.shape
	var original_transform := collision.transform
	var original_limits := Rect2(
		camera.limit_left,
		camera.limit_top,
		camera.limit_right - camera.limit_left,
		camera.limit_bottom - camera.limit_top,
	)
	for profile_index in range(PROFILE_PATHS.size()):
		var profile := load(PROFILE_PATHS[profile_index]) as VisualScaleProfileResource
		hero.call(&"set_appearance_height", profile.hero_height)
		var camera_profile := CameraProfileResource.new()
		camera_profile.base_zoom = profile.camera_zoom
		camera_profile.profile_name = profile.profile_name
		_expect(
			camera.call(&"set_profile", camera_profile) == OK,
			"HeroRoom accepts comparison profile %d" % profile_index,
		)
		_expect(
			is_equal_approx(float(hero.call(&"get_appearance_height")), profile.hero_height),
			"HeroRoom displays comparison profile %d hero height" % profile_index,
		)
		_expect(
			camera.zoom.is_equal_approx(Vector2.ONE * profile.camera_zoom),
			"HeroRoom displays comparison profile %d zoom" % profile_index,
		)
		_expect(
			collision.shape == original_shape and collision.transform == original_transform,
			"HeroRoom profile %d leaves hero collision unchanged" % profile_index,
		)
		_expect(
			Rect2(
				camera.limit_left,
				camera.limit_top,
				camera.limit_right - camera.limit_left,
				camera.limit_bottom - camera.limit_top,
			) == original_limits,
			"HeroRoom profile %d leaves camera limits unchanged" % profile_index,
		)
	await _close_scene(tree, hero_room)


func _open_scene(tree: SceneTree, packed_scene: PackedScene) -> Control:
	var node := packed_scene.instantiate()
	_expect(node is Control, "comparison scene instantiates as Control")
	if not node is Control:
		if node != null:
			node.free()
		return null
	var scene := node as Control
	tree.root.add_child(scene)
	await tree.process_frame
	return scene


func _close_scene(tree: SceneTree, scene: Control) -> void:
	scene.queue_free()
	await tree.process_frame


func _hero_size_id(hero_height: float) -> String:
	return ["small", "medium", "large"][ALL_HERO_HEIGHTS.find(hero_height)]


func _tile_size_id(tile_size: int) -> String:
	return ["small", "medium", "large"][ALL_TILE_SIZES.find(tile_size)]


func _camera_zoom_id(camera_zoom: float) -> String:
	return ["wide", "medium", "near"][ALL_CAMERA_ZOOMS.find(camera_zoom)]


func _format_zoom(camera_zoom: float) -> String:
	return ("%.2f" % camera_zoom).replace(".", ",")


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
	_expect(remove_error == OK, "isolated scale-candidate settings can be removed")


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("Visual scale candidates: %s" % description)
