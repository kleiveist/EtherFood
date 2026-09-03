extends Resource
class_name VisualScaleProfile

## Bundles the visual scale and rendering values of one profile.

@export var profile_id: String = ""
@export var profile_name: String = ""
@export_multiline var comparison_focus: String = ""

@export_range(1.0, 256.0, 1.0) var hero_height: float = 80.0
@export_range(1, 256, 1) var tile_size: int = 32
@export_range(0.1, 4.0, 0.05) var camera_zoom: float = 1.0

@export var reference_resolution := Vector2i(1920, 1080)
@export var aspect_ratio: String = "16:9"
@export var pixel_snap_enabled: bool = true
@export_enum("nearest", "soft") var texture_filter_id: String = "nearest"
