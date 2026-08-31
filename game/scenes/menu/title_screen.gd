extends Control

const MAIN_MENU_ROUTE := &"main_menu"

var _navigation_requested := false


func _unhandled_input(event: InputEvent) -> void:
	if _navigation_requested or not event.is_action_pressed(&"ui_accept"):
		return

	get_viewport().set_input_as_handled()
	_navigation_requested = true
	var navigation_error := SceneRouter.navigate(MAIN_MENU_ROUTE)
	if navigation_error == OK:
		return

	_navigation_requested = false
	push_error(
		"TitleScreen failed to navigate to route '%s' with error %d."
		% [MAIN_MENU_ROUTE, navigation_error],
	)
