extends LocomotionState

@onready var player: Node3D = $"../.."
@onready var head: Node3D = $"../../Locomotion/Head"

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter():
	if not player.locomotion == null:
		player.locomotion.elapsed_time = 0.0

func physics_update(delta: float) -> void:
	if player.locomotion.is_on_floor():
		if Input.is_action_pressed("duck"):
			transition.emit("Ducking")
			return
		
		transition.emit("Running")
		return
	
	player.locomotion.velocity.y -= gravity * delta
	
	player.process_input()
	player.locomotion.velocity = player.locomotion.update_velocity(delta, false)
	
	player.locomotion.move_and_slide()
