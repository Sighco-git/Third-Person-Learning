# Makes weapon gradually point to the center using RecenterMuzzle - RayCast3D node. 
extends Node3D

@export var recenter_muzzle: RayCast3D
@onready var weapon_holder: Node3D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	recenter_muzzle.force_raycast_update()
	if recenter_muzzle.is_colliding():
		var centered_shot = recenter_muzzle.get_collision_point()
		#weapon_holder.x = centered_shot.y
