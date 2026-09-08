extends Resource
class_name HeroMovementConfig

## Tunable movement values for the shared top-down hero controller.
##
## Speeds use world pixels per second. Durations use seconds, while jump
## distances and heights use world pixels. Gameplay Lab limits are repeated
## here so editor-authored and runtime-authored values share the same bounds.

@export_group("Movement speeds")
@export_range(40.0, 500.0, 5.0) var sneak_speed: float = 60.0
@export_range(40.0, 500.0, 5.0) var walk_speed: float = 100.0
@export_range(40.0, 500.0, 5.0) var jog_speed: float = 220.0
@export_range(40.0, 500.0, 5.0) var run_speed: float = 310.0
@export_range(40.0, 500.0, 5.0) var sprint_speed: float = 400.0

@export_group("Run activation")
@export_range(0.01, 1.0, 0.01) var double_tap_window: float = 0.30
@export_range(0.0, 1.0, 0.01) var direction_change_grace: float = 0.12

@export_group("Jump durations")
@export_range(0.01, 2.0, 0.01) var standing_jump_duration: float = 0.32
@export_range(0.01, 2.0, 0.01) var walk_jump_duration: float = 0.28
@export_range(0.01, 2.0, 0.01) var jog_jump_duration: float = 0.32
@export_range(0.01, 2.0, 0.01) var run_jump_duration: float = 0.40
@export_range(0.01, 2.0, 0.01) var sprint_jump_duration: float = 0.48

@export_group("Jump distances")
@export_range(16.0, 160.0, 1.0) var walk_jump_distance: float = 32.0
@export_range(16.0, 160.0, 1.0) var jog_jump_distance: float = 48.0
@export_range(16.0, 160.0, 1.0) var run_jump_distance: float = 80.0
@export_range(16.0, 160.0, 1.0) var sprint_jump_distance: float = 112.0

@export_group("Jump heights")
@export_range(8.0, 64.0, 1.0) var standing_jump_height: float = 24.0
@export_range(8.0, 64.0, 1.0) var walk_jump_height: float = 20.0
@export_range(8.0, 64.0, 1.0) var jog_jump_height: float = 24.0
@export_range(8.0, 64.0, 1.0) var run_jump_height: float = 30.0
@export_range(8.0, 64.0, 1.0) var sprint_jump_height: float = 36.0
