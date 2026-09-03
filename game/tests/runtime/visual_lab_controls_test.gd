extends RefCounted

const VISUAL_LAB_SCENE_PATH := "res://scenes/dev/visual_lab.tscn"
const SETTINGS_PATH_PROJECT_KEY := "etherfood/development/visual_lab_settings_path"
const SETTINGS_TEST_PATH := "user://visual_lab_controls_test.cfg"
const CONTROLS_ACTION := &"dev_controls_toggle"
const DIAGNOSTICS_ACTION := &"dev_diagnostics_toggle"
const EXPECTED_CONTROL_TEXTS: Array[String] = [
	"WASD / Pfeiltasten / linker Stick",
	"Esc / B",
	"- / linke Schultertaste: weiter",
	"+ / rechte Schultertaste: näher",
	"R / Controller links: kleiner",
	"F / Controller oben: größer",
	"T / linker Stick-Klick: kleiner",
	"G / rechter Stick-Klick: größer",
	"V / Controller-A: Zustand wechseln",
	"B / Klick / Auswahl: Nebel wechseln",
	"L / Klick / Auswahl: Licht wechseln",
	"X / Klick / Auswahl: AN / AUS",
	"N / Klick / Auswahl: Nearest / Weich",
	"F3 / Select: Diagnose",
	"F4: Kollisionsflächen",
	"F5: Steuerung schließen",
]
const VALUE_PREFIXES: Array[String] = [
	"Referenz:",
	"Fenster:",
	"Kamera:",
	"Figur:",
	"Tiles:",
	"Weltzustand:",
	"Testwerte werden",
]

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
		_expect_controls_contract(visual_lab)
		await _close_visual_lab(tree, visual_lab)

	var reopened_visual_lab := await _open_visual_lab(tree, packed_scene)
	if reopened_visual_lab != null:
		var panel := reopened_visual_lab.get_node_or_null(
			"InterfaceLayer/HudPanel"
		) as Panel
		var interface := reopened_visual_lab.get_node_or_null(
			"InterfaceLayer/Interface"
		) as MarginContainer
		_expect(
			panel != null and not panel.visible,
			"controls panel starts hidden after reopening",
		)
		_expect(
			interface != null and not interface.visible,
			"controls content starts hidden after reopening",
		)
		await _close_visual_lab(tree, reopened_visual_lab)

	_cleanup_test_path()
	return failures


func _expect_controls_contract(visual_lab: Control) -> void:
	var panel := visual_lab.get_node_or_null("InterfaceLayer/HudPanel") as Panel
	var interface := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface"
	) as MarginContainer
	var text_container := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text"
	) as VBoxContainer
	var title := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/Title"
	) as Label
	var prompt := visual_lab.get_node_or_null(
		"InterfaceLayer/ControlsPrompt"
	) as Label
	var diagnostics_panel := visual_lab.get_node_or_null(
		"InterfaceLayer/DiagnosticsPanel"
	) as Panel
	var pixel_snap_button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/RenderingButtons/PixelSnapButton"
	) as Button
	var texture_filter_button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/RenderingButtons/TextureFilterButton"
	) as Button
	var fog_variant_button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/AtmosphereButtons/FogVariantButton"
	) as Button
	var light_variant_button := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/AtmosphereButtons/LightVariantButton"
	) as Button
	var controls_toggle_hint := visual_lab.get_node_or_null(
		"InterfaceLayer/Interface/Text/ControlsToggleHint"
	) as Label

	_expect(panel != null, "VisualLab retains its framed controls panel")
	_expect(interface != null, "VisualLab has controls content")
	_expect(text_container != null, "controls use the existing text container")
	_expect(title != null and title.text == "STEUERUNG", "controls have a clear title")
	_expect(
		prompt != null and prompt.text == "F5 · Steuerung",
		"collapsed view explains the F5 shortcut",
	)
	_expect(pixel_snap_button != null, "controls have an interactive pixel-snap button")
	_expect(
		texture_filter_button != null,
		"controls have an interactive texture-filter button",
	)
	_expect(fog_variant_button != null, "controls have an interactive fog button")
	_expect(light_variant_button != null, "controls have an interactive light button")
	_expect(controls_toggle_hint != null, "controls retain their closing hint")
	if (
		panel == null
		or interface == null
		or text_container == null
		or prompt == null
		or pixel_snap_button == null
		or texture_filter_button == null
		or fog_variant_button == null
		or light_variant_button == null
		or controls_toggle_hint == null
	):
		return

	_expect(not panel.visible, "controls panel starts hidden")
	_expect(not interface.visible, "controls content starts hidden")
	_expect(prompt.visible, "F5 shortcut starts visible")
	_expect(
		not pixel_snap_button.is_visible_in_tree(),
		"pixel-snap menu button starts collapsed with the controls",
	)
	_expect(
		pixel_snap_button.text == "Pixel-Snap: AUS",
		"pixel-snap menu button starts with an exact state",
	)
	_expect(
		not texture_filter_button.is_visible_in_tree(),
		"texture-filter menu button starts collapsed with the controls",
	)
	_expect(
		texture_filter_button.text == "Texturfilter: Nearest-Neighbor",
		"texture-filter menu button starts with an exact state",
	)
	_expect(
		not fog_variant_button.is_visible_in_tree()
		and fog_variant_button.text == "Nebel: Mittel",
		"fog menu button starts collapsed with the preferred damaged variant",
	)
	_expect(
		not light_variant_button.is_visible_in_tree()
		and light_variant_button.text == "Licht: Kühl und dunkel",
		"light menu button starts collapsed with the preferred damaged profile",
	)
	_expect(
		diagnostics_panel != null and not diagnostics_panel.visible,
		"diagnostics remain independently hidden",
	)

	visual_lab._unhandled_input(_pressed_action(CONTROLS_ACTION))
	_expect(panel.visible, "F5 action shows the controls panel")
	_expect(interface.visible, "F5 action shows the controls content")
	_expect(not prompt.visible, "expanded controls replace the collapsed shortcut")
	_expect(pixel_snap_button.is_visible_in_tree(), "F5 shows the pixel-snap menu button")
	_expect(
		texture_filter_button.is_visible_in_tree(),
		"F5 shows the texture-filter menu button",
	)
	_expect(fog_variant_button.is_visible_in_tree(), "F5 shows the fog menu button")
	_expect(light_variant_button.is_visible_in_tree(), "F5 shows the light menu button")
	_expect(
		controls_toggle_hint.get_global_rect().end.y
		<= panel.get_global_rect().end.y - 12.0,
		"atmosphere controls keep the complete F5 menu inside its panel",
	)
	_expect(pixel_snap_button.has_focus(), "F5 focuses the interactive menu button")
	_expect_visible_content_is_controls_only(text_container)

	visual_lab._unhandled_input(_pressed_key(KEY_F5, true))
	_expect(panel.visible and interface.visible, "held F5 does not toggle repeatedly")
	visual_lab._unhandled_input(_pressed_key(KEY_F5))
	_expect(not panel.visible and not interface.visible, "second F5 press hides controls")
	_expect(prompt.visible, "collapsed F5 shortcut returns after closing controls")

	visual_lab._unhandled_input(_pressed_action(DIAGNOSTICS_ACTION))
	_expect(
		diagnostics_panel != null and diagnostics_panel.visible,
		"F3 still opens diagnostics without opening controls",
	)
	visual_lab._unhandled_input(_pressed_action(CONTROLS_ACTION))
	_expect(panel.visible and interface.visible, "F5 opens controls beside diagnostics")
	_expect(
		diagnostics_panel != null and diagnostics_panel.visible,
		"F5 does not change diagnostics visibility",
	)

	pixel_snap_button.button_pressed = true
	pixel_snap_button.pressed.emit()
	_expect(
		pixel_snap_button.text == "Pixel-Snap: AN",
		"menu selection updates the displayed pixel-snap state",
	)
	_expect(
		not visual_lab.get_viewport().snap_2d_transforms_to_pixel,
		"menu selection avoids independently rounding world transforms",
	)
	texture_filter_button.button_pressed = true
	texture_filter_button.pressed.emit()
	_expect(
		texture_filter_button.text == "Texturfilter: Weich",
		"menu selection updates the displayed texture-filter state",
	)
	fog_variant_button.pressed.emit()
	light_variant_button.pressed.emit()
	_expect(fog_variant_button.text == "Nebel: Hoch", "fog button cycles its variant")
	_expect(
		light_variant_button.text == "Licht: Kühl und gedämpft",
		"light button cycles its profile",
	)

	visual_lab._unhandled_input(_pressed_action(&"dev_hero_size_increase"))
	var settings := ConfigFile.new()
	_expect(settings.load(SETTINGS_TEST_PATH) == OK, "existing lab settings still save")
	_expect(
		not settings.has_section_key("visual_lab", "controls_visible"),
		"controls visibility is not persisted",
	)
	_expect(
		settings.get_value("visual_lab", "pixel_snap", false) == true,
		"pixel-snap menu choice is persisted as a test value",
	)
	_expect(
		settings.get_value("visual_lab", "texture_filter", "") == "soft",
		"texture-filter menu choice is persisted as a test value",
	)
	_expect(
		settings.get_value("visual_lab", "damaged_fog", "") == "high",
		"fog menu choice is persisted as a test value",
	)
	_expect(
		settings.get_value("visual_lab", "damaged_light", "") == "cool_muted",
		"light menu choice is persisted as a test value",
	)


func _expect_visible_content_is_controls_only(text_container: VBoxContainer) -> void:
	var visible_texts: Array[String] = []
	for descendant in text_container.find_children("*", "Label", true, false):
		var label := descendant as Label
		if label != null and label.is_visible_in_tree():
			visible_texts.append(label.text)
	for expected_text in EXPECTED_CONTROL_TEXTS:
		_expect(
			expected_text in visible_texts,
			"controls list contains '%s'" % expected_text,
		)
	for visible_text in visible_texts:
		for prefix in VALUE_PREFIXES:
			_expect(
				not visible_text.begins_with(prefix),
				"controls omit live value '%s'" % visible_text,
			)


func _expect_input_mapping() -> void:
	_expect(InputMap.has_action(CONTROLS_ACTION), "InputMap defines controls toggle")
	if not InputMap.has_action(CONTROLS_ACTION):
		return
	for input_event in InputMap.action_get_events(CONTROLS_ACTION):
		var key_event := input_event as InputEventKey
		if key_event != null and (
			key_event.keycode == KEY_F5 or key_event.physical_keycode == KEY_F5
		):
			return
	_expect(false, "controls toggle uses F5")


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
	_expect(remove_error == OK, "isolated controls settings can be removed")


func _expect(condition: bool, description: String) -> void:
	if not condition:
		failures.append("VisualLab controls: %s" % description)
