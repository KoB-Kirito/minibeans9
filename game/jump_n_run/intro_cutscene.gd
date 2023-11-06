extends Node


func _ready() -> void:
	Globals.paused = true
	
	Bgm.fade_out(0.5)
	
	await get_tree().create_timer(3).timeout
	
	Dialogic.signal_event.connect(dialogic_signal)
	Dialogic.timeline_ended.connect(show_healthbar)
	Dialogic.start("Opening Scene")


func show_healthbar() -> void:
	$"../CanvasLayer/Healtbar".show()


func dialogic_signal(signal_name: String) -> void:
	if signal_name == "fade":
		Bgm.fade_in(load("res://assets/sounds/bittersweet-eerie-horror-vocals-the-siren.ogg"), 1.0)
		var tween := create_tween()
		tween.tween_property($ColorRect, "modulate", Color(0.0, 0.0, 0.0, 0.0), 3.0)
		tween.tween_callback(func(): $ColorRect.queue_free())
