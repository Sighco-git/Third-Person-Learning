# Makes weapon point to the center using RecenterMuzzle - RayCast3D node. 
extends Node3D

@export var recenter_muzzle: RayCast3D
@onready var weapon_pivot: Node3D = $WeaponPivot

func _process(delta: float) -> void:
	recenter_muzzle.force_raycast_update()
	if recenter_muzzle.is_colliding():
		var centered_shot = recenter_muzzle.get_collision_point()
		weapon_pivot.look_at(centered_shot, Vector3.UP)
