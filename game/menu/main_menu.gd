extends Control


func _on_start_pressed():
	get_tree().change_scene_to_file("res://game/jump_n_run/level1.tscn") 


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://game/menu/settings.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://game/menu/credits.tscn")


func _on_quit_pressed() -> void:
	if OS.has_feature('JavaScript'):
		JavaScriptBridge.eval("""window.open('https://google.com', '_self');""")
	else:
		get_tree().quit()


var got_focus: bool = false
func _unhandled_input(event: InputEvent) -> void:
	if not got_focus and event is InputEventJoypadButton:
		got_focus = true
		$TextureRect/VBoxContainer/Start.grab_focus()
