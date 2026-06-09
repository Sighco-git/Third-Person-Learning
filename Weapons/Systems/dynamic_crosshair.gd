extends Sprite3D

@onready var muzzle_raycast: RayCast3D = $".."
@export var weight := 1.0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if muzzle_raycast.is_colliding() && Input.is_action_just_pressed("attack"):
		var predicted_shot = muzzle_raycast.get_collision_point()
		global_position = lerp(global_position, predicted_shot, weight) * delta
		print(predicted_shot)
