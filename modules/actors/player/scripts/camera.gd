extends Node3D

@export var sensitivity: float = 0.2

@onready var player: CharacterBody3D = $".."
@onready var fps_camera_parent: Node3D = $"."
@onready var fps_camera: Camera3D = $MainCamera

@onready var state_machine: StateMachine = $"../../StateMachine"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_handle_camera_rotation(event)
		
	if event is InputEventKey and Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit(0)

func _handle_camera_rotation(event: InputEvent):
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		
		fps_camera_parent.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		fps_camera_parent.rotation.x = clamp(fps_camera_parent.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _process(_delta):
	fps_camera_parent.position.y = player.head_height
