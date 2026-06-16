# Static crosshair to show true center.
extends Control

@onready var static_crosshair: Control = $"."

func _draw() -> void:
	draw_circle(Vector2.ZERO, 4, Color.DIM_GRAY)
	draw_circle(Vector2.ZERO, 3, Color.WHITE)
