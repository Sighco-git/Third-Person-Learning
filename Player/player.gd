extends CharacterBody3D

@onready var placeholder_mesh: MeshInstance3D = $PlaceholderMesh
@onready var spring_arm_3d: SpringArm3D = $Pivot/SpringArm3D
@onready var pivot: Node3D = $Pivot
@export var sensitivity := 0.005
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED  # hides + locks cursor
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * sensitivity)
		spring_arm_3d.rotation.x -= event.relative.y * sensitivity
		spring_arm_3d.rotation.x = clamp(
			spring_arm_3d.rotation.x,
			deg_to_rad(-75),   # looking down limit
			deg_to_rad(20)     # looking up limit
		)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	var direction = (pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	placeholder_mesh.rotation.y = input_dir.angle()
	move_and_slide()
