# script untuk scene SelectLevel.tscn, untuk memilih jenis level.

# diturunkan dari Control.
extends Control

# array jenis level.
export(Array, String) var level_sprite_name = []

# next scene.
export var next_scene_path = "res://Scenes/Level001.tscn"

# gambar jenis-jenis level.
onready var level_sprite = get_node("LevelSprite")

# index gambar level.
var level_sprite_name_index = 0

# saat ready
func _ready():
	level_sprite.set_texture(load("res://Textures/" + level_sprite_name[level_sprite_name_index] + ".png"))

# saat tombol Prev ditekan.
func _on_Prev_pressed():
	do_prev()
	level_sprite.set_texture(load("res://Textures/" + level_sprite_name[level_sprite_name_index] + ".png"))

# saat tombol Next ditekan.
func _on_Next_pressed():
	do_next()
	level_sprite.set_texture(load("res://Textures/" + level_sprite_name[level_sprite_name_index] + ".png"))

# untuk menentukan nilai index gambar level.
func do_next():
	level_sprite_name_index += 1
	if level_sprite_name_index >= level_sprite_name.size():
		level_sprite_name_index = 0;

# untuk menentukan nilai index gambar level.
func do_prev():
	level_sprite_name_index -= 1
	if level_sprite_name_index <= -1:
		level_sprite_name_index = level_sprite_name.size() - 1

# saat tombol Choose This Level ditekan.
func _on_ChooseThisLevel_pressed():
	# masukkan ke variabel global.
	Globals.chosen_level = level_sprite_name[level_sprite_name_index]
	
	# ganti ke scene terpilih.
	get_tree().change_scene("res://Scenes/" + Globals.chosen_level + ".tscn")
