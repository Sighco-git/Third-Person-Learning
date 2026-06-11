# Crosshair which shows the true location of anticipated attack
extends Sprite3D

@onready var muzzle_raycast: RayCast3D = $".."
@export var weight := 25.0 # Higher is snappier

func _process(delta: float) -> void:
	update_crosshair(delta)

func update_crosshair(delta: float) -> void:
	muzzle_raycast.force_raycast_update()
	if muzzle_raycast.is_colliding():
		var predicted_shot = muzzle_raycast.get_collision_point()
		global_position = lerp(global_position, predicted_shot, weight * delta)
