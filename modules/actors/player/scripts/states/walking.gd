extends LocomotionState

@onready var player: Node3D = $"../.."

func physics_update(delta: float) -> void:
	player.process_input()
	
	if not player.locomotion.is_on_floor():
		transition.emit("Airborne")
	
	if player.wish_jump:
		player.locomotion.velocity.y = player.locomotion.get_current_settings().JUMP_IMPULSE
	else:
		player.locomotion.velocity = player.locomotion.update_velocity(delta)
	
	player.locomotion.move_and_slide()
	player.locomotion.update_collider_height(delta)
	
	if Input.is_action_pressed("duck") or player.locomotion.has_collision_above($".".settings.HEIGHT):
		transition.emit("Ducking")
	
	if not Input.is_action_pressed("walk"):
		transition.emit("Running")
