extends Control

export(Array, String) var level_sprite_name = []

export var next_scene_path = "res://Scenes/Level001.tscn"

onready var level_sprite = get_node("LevelSprite")

var level_sprite_name_index = 0

func _ready():
	level_sprite.set_texture(load("res://Textures/" + level_sprite_name[level_sprite_name_index] + ".png"))

func _on_Prev_pressed():
	do_prev()
	level_sprite.set_texture(load("res://Textures/" + level_sprite_name[level_sprite_name_index] + ".png"))

func _on_Next_pressed():
	do_next()
	level_sprite.set_texture(load("res://Textures/" + level_sprite_name[level_sprite_name_index] + ".png"))
	
func do_next():
	level_sprite_name_index += 1
	if level_sprite_name_index >= level_sprite_name.size():
		level_sprite_name_index = 0;
		
func do_prev():
	level_sprite_name_index -= 1
	if level_sprite_name_index <= -1:
		level_sprite_name_index = level_sprite_name.size() - 1
		
func _on_ChooseThisLevel_pressed():
	Globals.chosen_level = level_sprite_name[level_sprite_name_index]
	get_tree().change_scene("res://Scenes/" + Globals.chosen_level + ".tscn")
