extends CanvasLayer

@export var settings_scene: PackedScene

func _unhandled_input(event: InputEvent) -> void:
	if Globals.paused:
		return
	
	if event.is_action_pressed("ui_cancel"):
		Globals.paused = true
		var settings := settings_scene.instantiate()
		add_child(settings)
