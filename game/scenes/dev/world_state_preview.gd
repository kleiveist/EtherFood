extends Node2D

enum WorldState {
	DAMAGED,
	RESTORED,
}

var current_state: int = WorldState.DAMAGED

@onready var damaged_state: Node2D = $DamagedState
@onready var restored_state: Node2D = $RestoredState


func _ready() -> void:
	set_world_state(current_state)


func set_world_state(value: int) -> void:
	current_state = clampi(
		value,
		WorldState.DAMAGED,
		WorldState.RESTORED,
	)
	damaged_state.visible = current_state == WorldState.DAMAGED
	restored_state.visible = current_state == WorldState.RESTORED


func is_restored() -> bool:
	return current_state == WorldState.RESTORED
