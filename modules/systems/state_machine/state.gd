"""
	Defines the State class. This class is an interface that defines methods to
be overriden by the implementations to be used by the State Machine class.
"""

class_name State
extends Node

signal transition(new_state_name: StringName)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
