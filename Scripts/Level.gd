extends Node

export var next_scene_path = "res://Scenes/End.tscn"
export var game_over_scene_path = "res://Scenes/GameOver.tscn"
export var game_over_flip_degree = 80
export var next_scene_target_group = "player"

onready var spawn = get_node("Spawn")

var player_car;

func _ready():
	# mulai dengan kursor tersembunyi
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# chosen car
	var chosen_car = Globals.chosen_car
	print(chosen_car)
	
	var chosen_car_ld = load("res://Prefabs/" + chosen_car + ".tscn")
	var chosen_car_instance = chosen_car_ld.instance()
	chosen_car_instance.global_transform = spawn.global_transform
	chosen_car_instance.add_to_group("player")
	add_child(chosen_car_instance)
		
	player_car = get_node(chosen_car)
	
func _input(_event):
	# toggle kursor di sini
	if _event is InputEventKey and _event.pressed and _event.scancode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if _event is InputEventMouseButton and _event.pressed and _event.button_index == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if player_car == null:
		return
		
	var try = player_car.transform.basis.y
	
	if abs(try.angle_to(Vector3.UP)) > deg2rad(game_over_flip_degree):
		print("flipped")
		get_tree().change_scene(game_over_scene_path)
	
func _on_Finish_body_entered(body):
	if body.get_groups().has(next_scene_target_group):
		print("finished")
		get_tree().change_scene(next_scene_path)


func _on_Fall_body_entered(body):
	if body.get_groups().has(next_scene_target_group):
		print("fall")
		get_tree().change_scene(game_over_scene_path)
