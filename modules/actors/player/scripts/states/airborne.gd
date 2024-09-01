extends LocomotionState

@onready var locomotion: CharacterBody3D = $"../../Locomotion"
@onready var player: Node3D = $"../.."
@onready var head: Node3D = $"../../Locomotion/Head"

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func physics_update(delta: float) -> void:
	if locomotion.is_on_floor():
		if Input.is_action_pressed("duck"):
			transition.emit("Ducking")
			return
		
		transition.emit("Running")
		return
	
	locomotion.velocity.y -= gravity * delta
	
	player.process_input()
	locomotion.velocity = locomotion.update_velocity(delta, false)
	
	locomotion.move_and_slide()
