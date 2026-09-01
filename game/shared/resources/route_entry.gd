extends Resource

@export var route_id: StringName = &""
@export var scene: PackedScene
@export var development_only: bool = false


func _init(
		p_route_id: StringName = &"",
		p_scene: PackedScene = null,
		p_development_only: bool = false,
) -> void:
	route_id = p_route_id
	scene = p_scene
	development_only = p_development_only


func is_available(debug_build: bool) -> bool:
	return not development_only or debug_build
