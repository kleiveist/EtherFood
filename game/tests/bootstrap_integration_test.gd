extends SceneTree

const EXPECTED_TITLE := "ETHERFOOD"
const EXPECTED_PROMPT := "Drücke eine Taste"
const EXPECTED_MAIN_MENU_HEADING := "Hauptmenü"
const EXPECTED_MAIN_MENU_BUTTONS := [
	"Fortsetzen",
	"Neues Spiel",
	"Einstellungen",
	"Mitwirkende",
	"Visuelles Testlabor",
	"Spiel beenden",
]
const EXPECTED_HERO_ROOM_TITLE := "HELDENRAUM"
const EXPECTED_HERO_ROOM_PLACEHOLDER := "Spielbarer Raum folgt"
const EXPECTED_VISUAL_LAB_TITLE := "VISUELLES TESTLABOR"
const EXPECTED_VISUAL_LAB_DESCRIPTION := "Interner Entwicklungsbereich\nGrafiktests folgen"
const EXPECTED_VISUAL_LAB_BACK_HINT := "Esc / B: Zurück"
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
		title_screen._unhandled_input(_pressed_action(&"ui_accept"))
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
				"MainMenu displays its heading",
			)
		var buttons := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons"
		) as VBoxContainer
		_expect(buttons != null, "MainMenu has a button list")
		if buttons != null:
			_expect(
				buttons.get_child_count() == EXPECTED_MAIN_MENU_BUTTONS.size(),
				"MainMenu has exactly six buttons in a debug build",
			)
			var inspected_button_count := mini(
				buttons.get_child_count(),
				EXPECTED_MAIN_MENU_BUTTONS.size(),
			)
			for index in range(inspected_button_count):
				var button := buttons.get_child(index) as Button
				_expect(button != null, "MainMenu child %d is a Button" % index)
				if button != null:
					_expect(
						button.text == EXPECTED_MAIN_MENU_BUTTONS[index],
						"MainMenu button %d has the expected text" % index,
					)
					_expect(
						button.is_visible_in_tree(),
						"MainMenu button '%s' is visible" % button.text,
					)

		var continue_button := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/ContinueButton"
		) as Button
		var new_game_button := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/NewGameButton"
		) as Button
		var settings_button := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/SettingsButton"
		) as Button
		var credits_button := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/CreditsButton"
		) as Button
		var visual_lab_button := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/VisualLabButton"
		) as Button
		var quit_button := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/QuitButton"
		) as Button
		_expect_disabled_menu_button(continue_button, "Fortsetzen")
		_expect_disabled_menu_button(settings_button, "Einstellungen")
		_expect_disabled_menu_button(credits_button, "Mitwirkende")
		_expect_disabled_menu_button(quit_button, "Spiel beenden")
		_expect(new_game_button != null, "MainMenu has the Neues Spiel button")
		if new_game_button != null:
			_expect(not new_game_button.disabled, "Neues Spiel is enabled")
			_expect(new_game_button.has_focus(), "Neues Spiel receives initial focus")
		_expect(visual_lab_button != null, "MainMenu has the visual laboratory button")
		if visual_lab_button != null:
			_expect(
				visual_lab_button.is_visible_in_tree(),
				"VisualLabButton is visible in a debug build",
			)
			_expect(not visual_lab_button.disabled, "VisualLabButton is enabled")
			_expect(
				visual_lab_button.focus_mode == Control.FOCUS_ALL,
				"VisualLabButton participates in debug-build focus navigation",
			)
			_expect(
				not visual_lab_button.has_focus(),
				"Neues Spiel keeps focus when VisualLabButton is available",
			)
			visual_lab_button.pressed.emit()

		_expect(
			scene_router.get_current_route_id() == &"visual_lab",
			"VisualLabButton opens the visual_lab route",
		)
		if route_host != null:
			_expect(
				route_host.get_child_count() == 1,
				"RouteHost owns one route after opening the visual laboratory",
			)
		var visual_lab := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/VisualLab"
		)
		_expect(visual_lab is Control, "visual_lab route loads the VisualLab scene")
		var visual_lab_title := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/VisualLab/Content/Text/Title"
		) as Label
		_expect(visual_lab_title != null, "VisualLab has a title Label")
		if visual_lab_title != null:
			_expect(
				visual_lab_title.text == EXPECTED_VISUAL_LAB_TITLE,
				"VisualLab displays its title",
			)
		var visual_lab_description := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/VisualLab/Content/Text/Description"
		) as Label
		_expect(visual_lab_description != null, "VisualLab has a description Label")
		if visual_lab_description != null:
			_expect(
				visual_lab_description.text == EXPECTED_VISUAL_LAB_DESCRIPTION,
				"VisualLab displays its placeholder description",
			)
		var visual_lab_back_hint := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/VisualLab/Content/Text/BackHint"
		) as Label
		_expect(visual_lab_back_hint != null, "VisualLab has a back-hint Label")
		if visual_lab_back_hint != null:
			_expect(
				visual_lab_back_hint.text == EXPECTED_VISUAL_LAB_BACK_HINT,
				"VisualLab displays its back hint",
			)

		if visual_lab != null:
			visual_lab._unhandled_input(_pressed_action(&"ui_cancel"))
		_expect(
			scene_router.get_current_route_id() == &"main_menu",
			"ui_cancel returns from the visual laboratory to the main menu",
		)
		if route_host != null:
			_expect(
				route_host.get_child_count() == 1,
				"RouteHost owns one route after leaving the visual laboratory",
			)
		var main_menu_after_visual_lab := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu"
		)
		_expect(
			main_menu_after_visual_lab is Control,
			"returning from the visual laboratory loads a fresh MainMenu scene",
		)
		var new_game_after_visual_lab := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/NewGameButton"
		) as Button
		_expect(
			new_game_after_visual_lab != null and new_game_after_visual_lab.has_focus(),
			"Neues Spiel regains focus after returning from the visual laboratory",
		)
		if new_game_after_visual_lab != null:
			new_game_after_visual_lab.pressed.emit()

		_expect(
			scene_router.get_current_route_id() == &"hero_room",
			"Neues Spiel opens the hero_room route",
		)
		if route_host != null:
			_expect(
				route_host.get_child_count() == 1,
				"RouteHost owns one route after opening the hero room",
			)
		var hero_room := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/HeroRoom"
		)
		_expect(hero_room is Control, "hero_room route loads the HeroRoom scene")
		var hero_room_title := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/HeroRoom/Content/Text/Title"
		) as Label
		_expect(hero_room_title != null, "HeroRoom has a title Label")
		if hero_room_title != null:
			_expect(
				hero_room_title.text == EXPECTED_HERO_ROOM_TITLE,
				"HeroRoom displays its title",
			)
		var hero_room_placeholder := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/HeroRoom/Content/Text/Placeholder"
		) as Label
		_expect(hero_room_placeholder != null, "HeroRoom has a placeholder Label")
		if hero_room_placeholder != null:
			_expect(
				hero_room_placeholder.text == EXPECTED_HERO_ROOM_PLACEHOLDER,
				"HeroRoom displays its placeholder",
			)

		if hero_room != null:
			hero_room._unhandled_input(_pressed_action(&"ui_cancel"))
		_expect(
			scene_router.get_current_route_id() == &"main_menu",
			"ui_cancel returns from the hero room to the main menu",
		)
		if route_host != null:
			_expect(
				route_host.get_child_count() == 1,
				"RouteHost owns one route after returning to the main menu",
			)
		var main_menu_after_hero_room := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu"
		)
		_expect(
			main_menu_after_hero_room is Control,
			"returning from the hero room loads a fresh MainMenu scene",
		)
		var new_game_after_hero_room := bootstrap.get_node_or_null(
			"ApplicationRoot/RouteHost/MainMenu/Content/Text/Buttons/NewGameButton"
		) as Button
		_expect(
			new_game_after_hero_room != null and new_game_after_hero_room.has_focus(),
			"Neues Spiel regains focus after returning from the hero room",
		)

		if main_menu_after_hero_room != null:
			main_menu_after_hero_room._unhandled_input(_pressed_action(&"ui_cancel"))
		_expect(
			scene_router.get_current_route_id() == &"title",
			"ui_cancel returns from the main menu to the title route",
		)
		if route_host != null:
			_expect(
				route_host.get_child_count() == 1,
				"RouteHost owns one route after returning to the title",
			)
		_expect(
			bootstrap.get_node_or_null("ApplicationRoot/RouteHost/TitleScreen") is Control,
			"returning loads a fresh TitleScreen scene",
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


func _pressed_action(action: StringName) -> InputEventAction:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	return event


func _expect_disabled_menu_button(button: Button, button_text: String) -> void:
	_expect(button != null, "MainMenu has the %s button" % button_text)
	if button == null:
		return
	_expect(button.disabled, "%s is disabled" % button_text)
	_expect(
		button.focus_mode == Control.FOCUS_NONE,
		"%s cannot receive focus" % button_text,
	)
	_expect(not button.has_focus(), "%s is not selected" % button_text)


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append(description)


func _finish() -> void:
	if failures.is_empty():
		print("EtherFood bootstrap integration test: passed")
		quit(0)
		return

	for failure in failures:
		push_error("Bootstrap integration test failed: %s" % failure)
	quit(1)
