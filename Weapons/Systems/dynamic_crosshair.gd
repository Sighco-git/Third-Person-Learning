extends Sprite3D

@onready var muzzle_raycast: RayCast3D = $".."
@export var weight := 15.0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_crosshair(delta)

func update_crosshair(delta: float) -> void:
	muzzle_raycast.force_raycast_update()
	if muzzle_raycast.is_colliding():
		var predicted_shot = muzzle_raycast.get_collision_point()
		global_position = lerp(global_position, predicted_shot, weight * delta)
