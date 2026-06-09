extends Sprite3D

@onready var muzzle_raycast: RayCast3D = $".."
@export var weight := 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if muzzle_raycast.is_colliding():
		var predicted_shot = muzzle_raycast.get_collision_point()
		position = lerp(position, predicted_shot, weight) * delta
