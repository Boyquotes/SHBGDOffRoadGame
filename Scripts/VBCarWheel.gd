# script ini untuk meningkatkan kualitas gerakan roda mobil (VehicleWheel),
# terutama saat roda menempel pada obstacle seperti batu (dalam game off road),
# jadi script ini harus ditempelkan ke VehicleWheel.

# diturunkan dari VehicleWheel.
extends VehicleWheel

# jumlah raycast.
export var raycast_count = 10

# offset radius roda.
export var wheel_radius_offset = 0.07

# faktor waktu pergerakan (untuk lerp).
export var movement_time_factor = 20.0

# metoda posisi atau impulse?
enum VBCAR_MOVE_METHOD { position, impulse }
export(VBCAR_MOVE_METHOD) var move_method = VBCAR_MOVE_METHOD.position

# referensi ke wheel mesh node.
onready var wheel_mesh = get_node("Wheel")

var force_applied = 0.0
# var last_contact_pos = Vector3()

# saat ready.
func _ready():
	pass

# tiap frame fisika.
func _physics_process(_delta):
	if move_method == VBCAR_MOVE_METHOD.position:
		do_raycast_wheel_pos_method(raycast_count, wheel_radius_offset, _delta)
	else:
		do_raycast_wheel_impulse_method(raycast_count, wheel_radius_offset, _delta)
	pass
	
func do_raycast_wheel_impulse_method(count, offset, _delta):
	var contact_positions = []
	for n in count:
		var self_rot = global_transform.basis.get_rotation_quat()
		var from = global_transform.origin
		var axis = self_rot * Quat(Vector3(deg2rad(360.0/count) * n, 0, 0)) * Vector3.DOWN
		var to = from + axis * (wheel_radius - abs(offset))
		var result = get_world().direct_space_state.intersect_ray(from, to, [get_parent()])
			
		if not result.empty() && result["position"]:
			contact_positions.append({"contact_pos": result["position"], "to": to})
		else:
			pass
			
	if contact_positions.size() == 0:
		return
		
	# metoda impulse
	var average_pos = Vector3()
	var average_to = Vector3()
	
	for item in contact_positions:
		average_pos += item["contact_pos"]
		average_to += item["to"]
		
	average_pos = average_pos / contact_positions.size()
	average_to = average_to / contact_positions.size()
	
	force_applied = lerp(force_applied, (average_to - average_pos).normalized().length() * 1000.0, movement_time_factor * _delta)
	get_parent().apply_impulse(
		get_parent().global_transform.basis.xform(get_parent().to_local(average_pos)), 
		Vector3.UP * force_applied
	)
	
func do_raycast_wheel_pos_method(count, offset, _delta):
	var contact_positions = []
	for n in count:
		var self_rot = global_transform.basis.get_rotation_quat()
		var from = global_transform.origin
		var axis = self_rot * Quat(Vector3(deg2rad(360.0/count) * n, 0, 0)) * Vector3.DOWN
		var to = from + axis * (wheel_radius - abs(offset))
		var result = get_world().direct_space_state.intersect_ray(from, to, [get_parent()])
		
		if not result.empty() && result["position"]:
			contact_positions.append(result["position"])
		else:
			pass
			
	if contact_positions.size() == 0:
		return
	
	# metoda posisi	
	var average = Vector3()
	for item in contact_positions:
		average += item
		
	average = average / contact_positions.size()
	wheel_mesh.global_transform.origin = lerp(wheel_mesh.global_transform.origin, average + (global_transform.origin - average).normalized() * (wheel_radius - abs(wheel_radius_offset)), movement_time_factor * _delta)
