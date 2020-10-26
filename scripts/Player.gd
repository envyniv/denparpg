extends KinematicBody

export var speed = 4
export(float, -1, 3) var wide
export(float, 0.4, 1.1) var tall
export(String, "start", "full", "all", "fullall") var AntennaState

var velocity = Vector2.ZERO

func get_input():
	if Input.is_action_pressed("ui_up"):
		pass
	if Input.is_action_pressed("ui_down"):
		pass
	if Input.is_action_pressed("ui_right"):
		pass
	if Input.is_action_pressed("ui_left"):
		pass
