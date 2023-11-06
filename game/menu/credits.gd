extends Control


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://game/menu/main_menu.tscn")


var got_focus: bool = false
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://game/menu/main_menu.tscn")
	
	if not got_focus and event is InputEventJoypadButton:
		got_focus = true
		$TextureRect/VBoxContainer/TextureButton.grab_focus()
