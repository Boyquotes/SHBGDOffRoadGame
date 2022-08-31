extends Control

export(Array, String) var car_sprite_name = []

export var next_scene_path = "res://Scenes/SelectLevel.tscn"

onready var car_sprite = get_node("CarSprite")

var car_sprite_name_index = 0

func _ready():
	car_sprite.set_texture(load("res://Textures/" + car_sprite_name[car_sprite_name_index] + ".png"))

func _on_Prev_pressed():
	do_prev()
	car_sprite.set_texture(load("res://Textures/" + car_sprite_name[car_sprite_name_index] + ".png"))

func _on_Next_pressed():
	do_next()
	car_sprite.set_texture(load("res://Textures/" + car_sprite_name[car_sprite_name_index] + ".png"))
	
func do_next():
	car_sprite_name_index += 1
	if car_sprite_name_index >= car_sprite_name.size():
		car_sprite_name_index = 0;
		
func do_prev():
	car_sprite_name_index -= 1
	if car_sprite_name_index <= -1:
		car_sprite_name_index = car_sprite_name.size() - 1
		
func _on_ChooseThisCar_pressed():
	Globals.chosen_car = car_sprite_name[car_sprite_name_index]
	get_tree().change_scene(next_scene_path)
