extends Spatial

# variabel export
export var x_speed = 5.0
export var y_speed = 5.0
export var z_speed = 20.0

# dan lain-lain
onready var horizontal = get_node("Horizontal")
onready var vertical = get_node("Horizontal/Vertical")
onready var clipped_camera = get_node("Horizontal/Vertical/ClippedCamera")

var input_mouse_horizontal = 0.0
var input_mouse_vertical = 0.0
var input_mouse_scroll = 0.0

func _input(_event):
	if _event is InputEventMouseMotion:
		input_mouse_horizontal = _event.relative.x * x_speed
		input_mouse_vertical = _event.relative.y * -y_speed
		
	if _event is InputEventMouseButton:
		if _event.is_pressed():
			if _event.button_index == BUTTON_WHEEL_UP:
				input_mouse_scroll = 1.0 * z_speed
			if _event.button_index == BUTTON_WHEEL_DOWN:
				input_mouse_scroll = -1.0 * z_speed
		
func _ready():
	pass
	
func _process(_delta):
	horizontal.rotation_degrees.y -= input_mouse_horizontal * _delta
	vertical.rotation_degrees.x += input_mouse_vertical * _delta
	clipped_camera.transform.origin += Vector3.FORWARD * input_mouse_scroll * _delta
	input_mouse_scroll = 0.0
	input_mouse_horizontal = 0.0
	input_mouse_vertical = 0.0

