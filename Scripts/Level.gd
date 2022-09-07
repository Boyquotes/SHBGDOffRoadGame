# ini adalah script yang mengatur scene level (Level001, Level002, dan seterusnya).

# diturunkan dari Node.
extends Node

# scene selanjutnya jika player menang.
export var next_scene_path = "res://Scenes/End.tscn"

# scene selanjutnya jika player kalah.
export var game_over_scene_path = "res://Scenes/GameOver.tscn"

# batasan untuk dianggap flip.
export var game_over_flip_degree = 80

# untuk collision detection dengan finish.
export var next_scene_target_group = "player"

# tempat mobil di-spawn.
onready var spawn = get_node("Spawn")

# referensi ke mobil player.
var player_car;

func _ready():
	# mulai dengan kursor tersembunyi.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# mobil terpilih.
	var chosen_car = Globals.chosen_car
	print(chosen_car)
	
	# muat prefab mobil.
	var chosen_car_ld = load("res://Prefabs/" + chosen_car + ".tscn")
	
	# buat instance nya.
	var chosen_car_instance = chosen_car_ld.instance()
	chosen_car_instance.global_transform = spawn.global_transform
	
	# masukkan ke group player.
	chosen_car_instance.add_to_group("player")
	
	# jadikan child scene dari scene ini.
	add_child(chosen_car_instance)
	
	# referensi ke mobil player.
	player_car = get_node(chosen_car)
	
func _input(_event):
	# toggle kursor di sini.
	if _event is InputEventKey and _event.pressed and _event.scancode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if _event is InputEventMouseButton and _event.pressed and _event.button_index == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if player_car == null:
		return
		
	# cek apakah mobil flipped.
	var try = player_car.transform.basis.y
	
	if abs(try.angle_to(Vector3.UP)) > deg2rad(game_over_flip_degree):
		print("flipped")
		# jika flipped maka game over.
		get_tree().change_scene(game_over_scene_path)

# saat finish.
func _on_Finish_body_entered(body):
	if body.get_groups().has(next_scene_target_group):
		print("finished")
		get_tree().change_scene(next_scene_path)

# saat jatuh keluar arena.
func _on_Fall_body_entered(body):
	if body.get_groups().has(next_scene_target_group):
		print("fall")
		get_tree().change_scene(game_over_scene_path)
