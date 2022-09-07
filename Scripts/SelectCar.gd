# script untuk scene SelectCar.tscn, untuk memilih jenis mobil.

# diturunkan dari Control.
extends Control

# array jenis mobil.
export(Array, String) var car_sprite_name = []

# next scene adalah untuk memilih level.
export var next_scene_path = "res://Scenes/SelectLevel.tscn"

# gambar jenis-jenis mobil.
onready var car_sprite = get_node("CarSprite")

# index gambar mobil.
var car_sprite_name_index = 0

# saat ready
func _ready():
	car_sprite.set_texture(load("res://Textures/" + car_sprite_name[car_sprite_name_index] + ".png"))

# saat tombol Prev ditekan.
func _on_Prev_pressed():
	do_prev()
	car_sprite.set_texture(load("res://Textures/" + car_sprite_name[car_sprite_name_index] + ".png"))

# saat tombol Next ditekan.
func _on_Next_pressed():
	do_next()
	car_sprite.set_texture(load("res://Textures/" + car_sprite_name[car_sprite_name_index] + ".png"))

# untuk menentukan nilai index gambar mobil.
func do_next():
	car_sprite_name_index += 1
	if car_sprite_name_index >= car_sprite_name.size():
		car_sprite_name_index = 0;

# untuk menentukan nilai index gambar mobil.	
func do_prev():
	car_sprite_name_index -= 1
	if car_sprite_name_index <= -1:
		car_sprite_name_index = car_sprite_name.size() - 1

# saat tombol Choose This Car ditekan.
func _on_ChooseThisCar_pressed():
	# masukkan ke variabel global.
	Globals.chosen_car = car_sprite_name[car_sprite_name_index]
	
	# ganti ke scene selanjutnya.
	get_tree().change_scene(next_scene_path)
