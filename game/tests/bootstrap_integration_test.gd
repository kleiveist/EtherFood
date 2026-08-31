extends SceneTree

const EXPECTED_TITLE := "ETHERFOOD"
const EXPECTED_PROMPT := "Drücke eine Taste"
const EXPECTED_MAIN_MENU_HEADING := "Hauptmenü"
const FORGE2D_PLACEHOLDER := "Forge2D"
const TEST_SUITES := [
	"res://tests/runtime/scene_router_test.gd",
	"res://tests/runtime/application_root_test.gd",
	"res://tests/runtime/input_map_test.gd",
	"res://tests/runtime/touch_action_adapter_test.gd",
]

var failures: PackedStringArray = []


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	await process_frame
	for suite_path in TEST_SUITES:
		await _run_suite(suite_path)
	await _test_bootstrap_contract()
	_finish()


func _run_suite(suite_path: String) -> void:
	var completion_sentinel := "runtime suite completes: %s" % suite_path
	failures.append(completion_sentinel)
	var suite_script := load(suite_path) as Script
	_expect(suite_script != null, "runtime suite loads: %s" % suite_path)
	if suite_script == null:
		return
	_expect(suite_script.can_instantiate(), "runtime suite parses: %s" % suite_path)
	if not suite_script.can_instantiate():
		return
	var suite: Variant = suite_script.new()
	var suite_failures: PackedStringArray = await suite.run(self)
	var sentinel_index := failures.find(completion_sentinel)
	if sentinel_index >= 0:
		failures.remove_at(sentinel_index)
	failures.append_array(suite_failures)


func _test_bootstrap_contract() -> void:
	var main_scene_path := str(ProjectSettings.get_setting("application/run/main_scene", ""))
	_expect(not main_scene_path.is_empty(), "project configures a main scene")
	if main_scene_path.is_empty():
		return

	var main_scene := load(main_scene_path) as PackedScene
	_expect(main_scene != null, "configured main scene can be loaded")
	if main_scene == null:
		return

	var bootstrap := main_scene.instantiate()
	var composition_failures: Array[Array] = []
	bootstrap.composition_failed.connect(
		func(error: Error, message: String) -> void:
			composition_failures.append([error, message])
	)
	root.add_child(bootstrap)
	await process_frame

	_expect(bootstrap is Control, "main scene is a Control")
	_expect(bootstrap.get_parent() == root, "main scene remains attached after ready")
	var bootstrap_script: Script = bootstrap.get_script()
	_expect(bootstrap_script != null, "main scene has an attached script")
	if bootstrap_script != null:
		_expect(
			bootstrap_script.resource_path == "res://src/bootstrap.gd",
			"main scene uses the bootstrap script",
		)

	_expect(composition_failures.is_empty(), "Bootstrap reports no composition failure")
	_expect(bootstrap.get_child_count() == 1, "Bootstrap creates exactly one child")

	var application_root := bootstrap.get_node_or_null("ApplicationRoot")
	_expect(application_root != null, "Bootstrap creates ApplicationRoot")
	if application_root != null:
		var application_script: Script = application_root.get_script()
		_expect(application_script != null, "ApplicationRoot has an attached script")
		if application_script != null:
			_expect(
				application_script.resource_path == "res://scenes/app/application_root.gd",
				"Bootstrap uses the production ApplicationRoot",
			)
		_expect(application_root.is_started(), "ApplicationRoot completes startup")
		_expect(
			application_root.get_node_or_null("PersistentUI") is CanvasLayer,
			"ApplicationRoot has persistent UI CanvasLayer",
		)
		_expect(
			application_root.get_node_or_null("TransitionLayer") is CanvasLayer,
			"ApplicationRoot has transition CanvasLayer",
		)

	var route_host := bootstrap.get_node_or_null("ApplicationRoot/RouteHost")
	_expect(route_host != null, "ApplicationRoot owns RouteHost")
	if route_host != null:
		_expect(route_host.get_child_count() == 1, "RouteHost owns one active route")

	var scene_router := root.get_node_or_null("SceneRouter")
	_expect(scene_router != null, "SceneRouter is registered as an Autoload")
	if scene_router != null:
		_expect(
			scene_router.get_current_route_id() == &"title",
			"ApplicationRoot starts on the title route",
		)

	var title_screen := bootstrap.get_node_or_null(
		"ApplicationRoot/RouteHost/TitleScreen"
	)
	_expect(title_screen is Control, "initial route is the TitleScreen")
	var title_label := bootstrap.get_node_or_null(
		"ApplicationRoot/RouteHost/TitleScreen/Content/Text/Title"
	) as Label
	_expect(title_label != null, "TitleScreen has a title Label")
	if title_label != null:
		_expect(title_label.text == EXPECTED_TITLE, "TitleScreen displays ETHERFOOD")
	var prompt_label := bootstrap.get_node_or_null(
		"ApplicationRoot/RouteHost/TitleScreen/Content/Text/Prompt"
	) as Label
	_expect(prompt_label != null, "TitleScreen has a prompt Label")
	if prompt_label != null:
		_expect(prompt_label.text == EXPECTED_PROMPT, "TitleScreen displays its input prompt")
	_expect(
		not _contains_label_text(bootstrap, FORGE2D_PLACEHOLDER),
		"no Forge2D placeholder text remains visible",
	)

	if title_screen != null and scene_router != null:
		var accept_event := InputEventAction.new()
		accept_event.action = &"ui_accept"
		accept_event.pressed = true
		title_screen._unhandled_input(accept_event)
		_expect(
			scene_router.get_current_route_id() == &"main_menu",
			"ui_accept opens the main menu route",
		)
		if route_host != null:
			_expect(
				route_host.get_child_count() == 1,
				"RouteHost owns one route after opening the main menu",
			)
		var main_menu := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu"
		)
		_expect(main_menu is Control, "main_menu route loads the MainMenu scene")
		var main_menu_title := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Title"
		) as Label
		_expect(main_menu_title != null, "MainMenu has a title Label")
		if main_menu_title != null:
			_expect(main_menu_title.text == EXPECTED_TITLE, "MainMenu displays ETHERFOOD")
		var main_menu_heading := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Heading"
		) as Label
		_expect(main_menu_heading != null, "MainMenu has a heading Label")
		if main_menu_heading != null:
			_expect(
				main_menu_heading.text == EXPECTED_MAIN_MENU_HEADING,
				"MainMenu displays its placeholder heading",
			)

	bootstrap.queue_free()
	await process_frame
	if scene_router != null:
		_expect(not scene_router.is_configured(), "Bootstrap shutdown clears SceneRouter")
		_expect(scene_router.get_current_route() == null, "shutdown releases route reference")


func _contains_label_text(root_node: Node, expected_text: String) -> bool:
	var label_nodes: Array[Node] = root_node.find_children("*", "Label", true, false)
	for label_node in label_nodes:
		var label := label_node as Label
		if label != null and label.text.contains(expected_text):
			return true
	return false


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append(description)


func _finish() -> void:
	if failures.is_empty():
		print("Forge2D bootstrap integration test: passed")
		quit(0)
		return

	for failure in failures:
		push_error("Bootstrap integration test failed: %s" % failure)
	quit(1)
