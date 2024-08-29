"""
	Resource containing the movement settings for a given state of an actor.
"""

extends Resource
class_name LocomotionSettings

@export_category("Physics")
var GRAVITY: float = ProjectSettings.get_setting("physics/3d/default_gravity")
## The impulse applied to the CharacterBody3D in the Y axis upon a jump command.
@export var JUMP_IMPULSE = sqrt(3 * GRAVITY * 0.85)
## Friction applied to the CharacterBody3D when moving along the ground.
@export var FRICTION: float

@export_category("Movement")
@export var MAX_VELOCITY: float
@export var MAX_ACCELERATION: float
@export var STOP_SPEED: float

@export_category("Perspective")
## The height of the LocomotionCollider.
@export_range(0.3, 1.8) var HEIGHT: float
