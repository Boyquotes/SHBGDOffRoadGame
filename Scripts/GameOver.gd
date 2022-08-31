extends Control

export var next_scene_path = "res://Scenes/StartMenu.tscn"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Restart_pressed():
	get_tree().change_scene(next_scene_path)
