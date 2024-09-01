extends Node3D

@onready var locomotion: CharacterBody3D = $Locomotion
@onready var state_machine: StateMachine = $StateMachine

var wish_jump: bool = false

func _ready() -> void:
	locomotion.state_machine = state_machine

func process_input():
	var wish_dir: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		wish_dir -= locomotion.transform.basis.z
		
	if Input.is_action_pressed("move_backward"):
		wish_dir += locomotion.transform.basis.z
	
	if Input.is_action_pressed("move_left"):
		wish_dir -= locomotion.transform.basis.x
	
	if Input.is_action_pressed("move_right"):
		wish_dir += locomotion.transform.basis.x
	
	locomotion.wish_dir = wish_dir.normalized()
	wish_jump = Input.is_action_just_pressed("jump")
