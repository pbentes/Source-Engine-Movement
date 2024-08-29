"""
	This script implements source style movement.
"""

extends CharacterBody3D

## The locomotion settings of the current state.
@export var current_settings: LocomotionSettings
## The direction the actor wishes to move in.
@export var wish_dir: Vector3
## The height the head attachment should be placed at according to the collider height.
@export var head_height: float

@onready var step_collider: CollisionShape3D = $StepCollider
@onready var locomotion_collider: CollisionShape3D = $LocomotionCollider
@onready var shape_cast: ShapeCast3D = $ShapeCast3D

func accelerate(max_velocity: float, delta: float) -> Vector3:
	var current_speed = velocity.dot(wish_dir)
	var add_speed = clamp(max_velocity - current_speed, 0, current_settings.MAX_ACCELERATION * delta)
	return velocity + add_speed * wish_dir

func update_velocity(delta: float, apply_friction: bool = true) -> Vector3:
	update_step_collider_position()
	if apply_friction:
		var speed = velocity.length()
		
		if speed != 0:
			var control = max(current_settings.STOP_SPEED, speed)
			var drop = control * current_settings.FRICTION * delta
			velocity *= max(speed - drop, 0) / speed
	return accelerate(current_settings.MAX_VELOCITY, delta)

func update_step_collider_position():
	var step_shape: SeparationRayShape3D = step_collider.shape
	var collider_shape: CylinderShape3D = locomotion_collider.shape
	
	var greatest_vector: Vector3
	if wish_dir.length() > velocity.length():
		greatest_vector = wish_dir
	else:
		greatest_vector = velocity
	
	if not wish_dir == Vector3.ZERO:
		var current_step_collider_position: Vector3 = greatest_vector.normalized().rotated(Vector3.UP, -rotation.y) * (collider_shape.radius + 0.4) 
		step_collider.position = Vector3(current_step_collider_position.x, step_shape.length, current_step_collider_position.z)

func has_collision_above(h: float) -> bool:
	shape_cast.add_exception(self)
	shape_cast.shape.height = h - 0.1
	shape_cast.position.y = h / 2 + 0.05
	return not shape_cast.collision_result.is_empty()

## Needs a cleanup pass
var duration: float = .5
var elapsed_time = 0.0
func update_collider_height(delta: float, h: float = current_settings.HEIGHT) -> bool:
	var t = clamp(elapsed_time / duration, 0, 1)
	var current_collider_shape: CylinderShape3D = locomotion_collider.shape
	
	if t == 1.0 and current_collider_shape.height >= h - 0.01:
		return true
	
	if current_collider_shape.height < h and t < 1.0:
		shape_cast.add_exception(self)
		
		shape_cast.shape.height = h - 0.1
		shape_cast.position.y = h / 2 + 0.05
		
		if not shape_cast.collision_result.is_empty():
			return false
	
	locomotion_collider.shape.height = lerpf(current_collider_shape.height, h, t)
	locomotion_collider.position.y = locomotion_collider.shape.height / 2
	head_height = locomotion_collider.shape.height - 0.1
	
	elapsed_time += delta
	return false
