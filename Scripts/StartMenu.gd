# ini adalah script untuk mengatur scene StartMenu.tscn.

# diturunkan dari Control.
extends Control

# next scene.
export var next_scene_path = "res://Scenes/SelectCar.tscn"

# saat ready.
func _ready():
	# tampilkan mouse cursor.
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# saat tombol Start ditekan.
func _on_Start_pressed():
	get_tree().change_scene(next_scene_path)

# saat tombol Quit ditekan.
func _on_Quit_pressed():
	get_tree().quit()
