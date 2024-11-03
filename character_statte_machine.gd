extends Node

class_name CharacterStateMachine

@export var currentState : State

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
		else:
			push_warning("Child" + child.name + " isn't a state in the machine dummy")

#func checkCanMove():
#	return currentState.can_move
