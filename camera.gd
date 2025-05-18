extends Camera2D

var camera_speed = 1500.
var zoom_speed = 0.1
var min_zoom := Vector2(0.15, 0.15)
var max_zoom := Vector2(10.0, 10.0)
var is_middle_mouse_pressed = false
var last_mouse_position = Vector2.ZERO
var middle_click_multiplier = 1.1

func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	direction = direction.normalized() * camera_speed * delta
	position += direction

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.pressed:
				is_middle_mouse_pressed = true
				last_mouse_position = event.position
			else:
				is_middle_mouse_pressed = false

	elif event is InputEventMouseMotion and is_middle_mouse_pressed:
		var mouse_movement = event.position - last_mouse_position
		position -= middle_click_multiplier * mouse_movement / zoom  # Adjust for zoom level
		last_mouse_position = event.position
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_WHEEL_DOWN):
		if (zoom - Vector2(zoom_speed, zoom_speed)) > Vector2.ZERO:
			zoom -= Vector2(zoom_speed, zoom_speed)
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_WHEEL_UP):
		zoom += Vector2(zoom_speed, zoom_speed)
	zoom.x = clamp(zoom.x, min_zoom.x, max_zoom.x)
	zoom.y = clamp(zoom.y, min_zoom.y, max_zoom.y)
