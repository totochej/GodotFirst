extends Node2D

var dragging = false
var ground_check_ray_length = 10
var initial_position = Vector2.ZERO
var is_jumping = false
var max_impulse_force = 10000
var projectile = null
var time_scale_original = 1.0

onready var global = get_node("/root/Globals")
		
func _ready():
	time_scale_original = Engine.time_scale
	projectile = self

func _physics_process(delta):
	var ray_start = global_position
	var ray_end = ray_start + Vector2(0, ground_check_ray_length)
	var collision = get_world_2d().direct_space_state.intersect_ray(ray_start, ray_end)
	
	if collision and collision.collider is TileMap:
		is_jumping = false
	
func _input(event):
	if global.game_over == false:
		if event is InputEventMouseButton and !is_jumping:
			if event.button_index == BUTTON_LEFT:
				if event.pressed:  # Mouse button pressed
					on_mouse_click(event.position)
				else:  # Mouse button released
					on_mouse_release(event.position)

func on_mouse_click(position):
	dragging = true
	initial_position = position
	Engine.time_scale = 0.2

func on_mouse_release(position):
	dragging = false
	var drag_vector = position - initial_position
	var force_magnitude = drag_vector.length()
	var force_scale = 50
	var impulse = drag_vector.normalized() * force_magnitude * force_scale
	impulse = impulse.clamped(max_impulse_force)
	Engine.time_scale = time_scale_original
	projectile.set_linear_velocity(Vector2.ZERO)
	projectile.apply_impulse(Vector2.ZERO, impulse)
	is_jumping = true
