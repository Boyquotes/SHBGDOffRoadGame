# ini adalah script yang mengatur End.tscn atau ending scene.

# diturunkan dari Control.
extends Control

# path ke next scene, artinya setelah scene ini akan kembali ke scene StartMenu.tscn.
export var next_scene_path = "res://Scenes/StartMenu.tscn"

# saat ready.
func _ready():
	# tampilkan mouse cursor.
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# saat tombol restart ditekan.
func _on_Restart_pressed():
	# ganti scene ke next scene.
	get_tree().change_scene(next_scene_path)
