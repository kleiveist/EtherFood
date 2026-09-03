extends Resource
class_name HeroMovementConfig

## Tunable movement values for the shared top-down hero controller.
##
## Speeds use world pixels per second. Durations use seconds, while jump
## distances and heights use world pixels.

@export_group("Movement speeds")
@export_range(0.0, 1000.0, 1.0) var walk_speed: float = 220.0
@export_range(0.0, 1000.0, 1.0) var run_speed: float = 310.0
@export_range(0.0, 1000.0, 1.0) var boost_speed: float = 400.0
@export_range(0.0, 1000.0, 1.0) var sneak_speed: float = 100.0

@export_group("Run activation")
@export_range(0.01, 1.0, 0.01) var double_tap_window: float = 0.30
@export_range(0.0, 1.0, 0.01) var direction_change_grace: float = 0.12
@export_range(0.01, 30.0, 0.1) var boost_duration: float = 5.0

@export_group("Jump durations")
@export_range(0.01, 2.0, 0.01) var normal_jump_duration: float = 0.32
@export_range(0.01, 2.0, 0.01) var run_jump_duration: float = 0.40
@export_range(0.01, 2.0, 0.01) var boost_jump_duration: float = 0.48

@export_group("Jump distances")
@export_range(0.0, 500.0, 1.0) var normal_jump_distance: float = 48.0
@export_range(0.0, 500.0, 1.0) var run_jump_distance: float = 80.0
@export_range(0.0, 500.0, 1.0) var boost_jump_distance: float = 112.0

@export_group("Jump heights")
@export_range(0.0, 200.0, 1.0) var normal_jump_height: float = 24.0
@export_range(0.0, 200.0, 1.0) var run_jump_height: float = 30.0
@export_range(0.0, 200.0, 1.0) var boost_jump_height: float = 36.0
