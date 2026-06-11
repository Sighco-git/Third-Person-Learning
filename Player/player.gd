extends CharacterBody3D

# Camera Stuff
@onready var player_camera: Camera3D = $Pivot/SpringArm3D/PlayerCamera
@onready var pivot: Node3D = $Pivot
@onready var spring_arm_3d: SpringArm3D = $Pivot/SpringArm3D
# Mouse Sensitivity
@export var sensitivity := 0.005
# Visuals
@onready var weapon_holder: Node3D = $WeaponHolder
@onready var placeholder_mesh: MeshInstance3D = $PlaceholderMesh

const SPEED = 5.0

func _ready() -> void:
	# Hide cursor / keep mouse locked to game window
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	# Camera movement
	if event is InputEventMouseMotion:
		# Pivot controls y axis
		pivot.rotate_y(-event.relative.x * sensitivity)
		# Springarm controls x axis
		spring_arm_3d.rotation.x -= event.relative.y * sensitivity
		spring_arm_3d.rotation.x = clamp(
			spring_arm_3d.rotation.x,
			deg_to_rad(-75),   # looking down limit in degrees
			deg_to_rad(70)     # looking up limit in degrees
		)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	# Use pivot.basis so movement direction is tied to camera horizontal movement.
	var direction = (pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	# Rotate player mesh to match input direction.
	placeholder_mesh.rotation.y = input_dir.angle()
	move_and_slide()
