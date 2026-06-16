extends Node3D

@onready var muzzle_raycast: RayCast3D = $Muzzle/MuzzleRaycast
@onready var dust: GPUParticles3D = $Muzzle/Dust

func shoot() -> void:
	if muzzle_raycast.is_colliding() && Input.is_action_just_pressed("attack"):
		var hit_point = muzzle_raycast.get_collision_point()
		print("Shot at: ", hit_point)
