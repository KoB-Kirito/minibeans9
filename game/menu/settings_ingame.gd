extends Control


func _ready() -> void:
	# set current volume
	$TextureRect/VBoxContainer3/VBoxContainer2/HSlider.value = AudioServer.get_bus_volume_db(0)
	$TextureRect/VBoxContainer3/VBoxContainer3/CheckBox.button_pressed = DisplayServer.window_get_mode(0) == DisplayServer.WINDOW_MODE_FULLSCREEN


func _on_texture_button_pressed():
	exit()


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


var got_focus: bool = false
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		exit()
		return
	
	if not got_focus and event is InputEventJoypadButton:
		got_focus = true
		$TextureRect/VBoxContainer3/VBoxContainer2/HSlider.grab_focus()


func exit() -> void:
	Globals.paused = false
	queue_free()


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
