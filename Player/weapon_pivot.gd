extends Node3D

@export var lag_speed := 8.0
@export var tilt_strength := 0.04
@export var tilt_recovery := 6.0

var mouse_delta_x := 0.0
var target_local_rot := Vector3.ZERO

func _process(delta):
	# Lag target is just resting local rotation (0,0,0)
	# The camera already moved — we're lagging back toward neutral
	target_local_rot = Vector3.ZERO
	
	rotation.x = lerp_angle(rotation.x, target_local_rot.x, lag_speed * delta)
	rotation.y = lerp_angle(rotation.y, target_local_rot.y, lag_speed * delta)
	
	# Tilt on Z from horizontal mouse movement
	var target_tilt = -mouse_delta_x * tilt_strength
	rotation.z = lerp_angle(rotation.z, target_tilt, tilt_recovery * delta)
	
	mouse_delta_x = 0.0
