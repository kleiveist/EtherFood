extends Node

const STAND_ACTION := &"stand"
const WALK_ACTION := &"walk"
const HERO_SCRIPT := preload("res://scenes/gameplay/hero/hero_character.gd")

@export var hero_path: NodePath = ^".."
@export var hero_sprite_path: NodePath = (
	^"../Visual/JumpVisual/Appearance/TextureScale/HeroSprite"
)

@onready var _hero: HERO_SCRIPT = get_node_or_null(hero_path) as HERO_SCRIPT
@onready var _hero_sprite: AnimatedSprite2D = (
	get_node_or_null(hero_sprite_path) as AnimatedSprite2D
)

var _current_action := &""


func _ready() -> void:
	if _hero == null or _hero_sprite == null or _hero_sprite.sprite_frames == null:
		push_error("GreenHeroAnimationController could not resolve its hero or sprite.")
		set_physics_process(false)
		return
	_apply_animation(STAND_ACTION, false)


func _physics_process(_delta: float) -> void:
	if _hero.is_jumping():
		_apply_animation(STAND_ACTION, true)
		return
	if _hero.is_ground_motion_active():
		_apply_animation(WALK_ACTION, false)
		return
	_apply_animation(STAND_ACTION, false)


## Returns the directional animation currently selected for the Green Hero.
func get_current_animation() -> StringName:
	if _hero_sprite == null:
		return &""
	return _hero_sprite.animation


func _apply_animation(action: StringName, freeze_first_frame: bool) -> void:
	var animation_name := StringName(
		"%s_%s" % [action, _hero.get_animation_direction_name()]
	)
	if not _hero_sprite.sprite_frames.has_animation(animation_name):
		push_error("Green Hero animation is unavailable: %s" % animation_name)
		set_physics_process(false)
		return

	if _hero_sprite.animation == animation_name:
		_current_action = action
		if freeze_first_frame:
			_hero_sprite.pause()
			_hero_sprite.set_frame_and_progress(0, 0.0)
		elif not _hero_sprite.is_playing():
			_hero_sprite.play()
		return

	var preserve_walk_phase := (
		action == WALK_ACTION and _current_action == WALK_ACTION
	)
	var previous_frame := _hero_sprite.frame
	var previous_progress := _hero_sprite.frame_progress
	_hero_sprite.play(animation_name)
	if preserve_walk_phase:
		var frame_count := _hero_sprite.sprite_frames.get_frame_count(animation_name)
		_hero_sprite.set_frame_and_progress(
			mini(previous_frame, frame_count - 1),
			previous_progress,
		)
	if freeze_first_frame:
		_hero_sprite.pause()
		_hero_sprite.set_frame_and_progress(0, 0.0)
	_current_action = action
