"""
	Defines the State Machine class. This class handles the lifecycle of the
states that implement the gameplay.
"""

class_name StateMachine
extends Node

@export var CURRENT_STATE: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State machine contains incompatible child node")
	
	CURRENT_STATE.enter()

func _process(delta):
	CURRENT_STATE.update(delta)

func _physics_process(delta):
	CURRENT_STATE.physics_update(delta)

func get_state(state_name: StringName) -> State:
	return states.get(state_name)

func on_child_transition(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != CURRENT_STATE:
			CURRENT_STATE.exit()
			CURRENT_STATE = new_state
			CURRENT_STATE.enter()
	else:
		push_warning("State does not exist")
