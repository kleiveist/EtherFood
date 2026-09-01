extends Resource

const RouteEntry := preload("res://shared/resources/route_entry.gd")

@export var entries: Array[RouteEntry] = []


func validation_errors() -> PackedStringArray:
	var errors := PackedStringArray()
	var seen_ids := {}

	for index in range(entries.size()):
		var entry := entries[index]
		if entry == null:
			errors.append("Route entry %d is missing." % index)
			continue
		if entry.route_id == &"":
			errors.append("Route entry %d has an empty ID." % index)
		elif seen_ids.has(entry.route_id):
			errors.append("Route ID '%s' is duplicated." % entry.route_id)
		else:
			seen_ids[entry.route_id] = true
		if entry.scene == null:
			errors.append("Route '%s' has no PackedScene." % entry.route_id)

	return errors


func is_valid() -> bool:
	return validation_errors().is_empty()


func scene_for(route_id: StringName) -> PackedScene:
	return scene_for_build(route_id, OS.is_debug_build())


func scene_for_build(route_id: StringName, debug_build: bool) -> PackedScene:
	for entry in entries:
		if (
			entry != null
			and entry.route_id == route_id
			and entry.is_available(debug_build)
		):
			return entry.scene
	return null


func route_ids() -> Array[StringName]:
	return route_ids_for_build(OS.is_debug_build())


func route_ids_for_build(debug_build: bool) -> Array[StringName]:
	var ids: Array[StringName] = []
	for entry in entries:
		if entry != null and entry.is_available(debug_build):
			ids.append(entry.route_id)
	return ids
